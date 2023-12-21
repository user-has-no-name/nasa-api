import Commons
import DependencyInjection
import SwiftUI
import NasaAPIService
import SecretsManager
import UICommons

public final class DashboardViewModel: ObservableObject {
    @Injected private var nasaService: NasaAPIService
    @Injected private var secretsManager: SecretsManager

    @Published var popupConfig: PopupWithDatePickerModel?
    @Published var showRoverPicker: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var bottomSheetType: BottomSheetWithPickerType = .camera
    @Published var toastConfig: Toast?

    @Published var selectedRover: RoverType = .defaultValue
    @Published var selectedCamera: RoverCameraAbbreviation = .defaultValue
    @Published var selectedDate: Date = .init()

    @Published var loading: Bool = false
    @Published var photos: MarsPhotos = .init(photos: .init())

    var currentPage: Int = 1

    var selectedValues: Array<AnyHashable> {[
        selectedRover,
        selectedCamera,
        selectedDate
    ]}

    public init() {}

    @MainActor
    func fetchPhotos() async {
//        loading = true
        do {
            let fetchedPhotos: MarsPhotos = try await nasaService.getPhotosFromRover(
                using: .init(
                    roverName: selectedRover.rawValue,
                    date: selectedDate.toString(),
                    camera: selectedCamera.rawValue,
                    page: "\(currentPage)",
                    apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()
                )
            )

            if !fetchedPhotos.photos.isEmpty {
                photos.photos.append(contentsOf: fetchedPhotos.photos)
                currentPage += 1
            } else {
                guard currentPage != 1 else {
                    toastConfig = .init(style: .info, message: "No images found")
                    #warning("Add empty state")
                    return
                }

                toastConfig = .init(style: .info, message: "There is no more images")
            }

//            loading = false
        } catch {
            toastConfig = .init(style: .error, message: "Error occurred \(error.localizedDescription)")
//            loading = false
        }
    }

    func loadMoreIfNeeded(lastAppearedCard: RoverPhoto) async {
        guard photos.photos.last?.id == lastAppearedCard.id else { return }
        await fetchPhotos()
    }

    func clearResults() {
        currentPage = 1
        photos.photos.removeAll()
    }

    func showBottomSheetPicker(of type: BottomSheetWithPickerType) {
        withAnimation {
            showCameraPicker = type == .camera
            showRoverPicker = type == .rover
        }
        bottomSheetType = type
    }

    func cameraPickerViewModel() -> BottomSheetViewModel<RoverCameraAbbreviation> {
        .init(
            with: BottomSheetWithPickerType.camera.rawValue,
            pickerValues: selectedRover.availableCameras,
            selectedValue: selectedCamera,
            listener: self
        )
    }

    func roverPickerViewModel() -> BottomSheetViewModel<RoverType> {
        .init(
            with: BottomSheetWithPickerType.rover.rawValue,
            pickerValues: RoverType.allCases,
            selectedValue: selectedRover,
            listener: self
        )
    }

    func showPopup() {
        popupConfig = .init(
            title: "Date",
            selectedDate: selectedDate,
            onSaveTappedAction: { [weak self] date in
                self?.selectedDate = date
                self?.closePopup()
            },
            onCancelTappedAction: { [weak self] in
                self?.closePopup()
            }
        )
    }

    private func closePopup() {
        popupConfig = nil
    }
}

extension DashboardViewModel: BottomSheetListener {

    public func tapOnAccept<Value>(_ selectedValue: Value) where Value: Pickable {
        switch selectedValue {
        case let cameraAbbreviation as RoverCameraAbbreviation:
            selectedCamera = cameraAbbreviation
        case let roverType as RoverType:
            selectedRover = roverType
        default:
            break
        }

        recalculateAvailability()
    }

    private func recalculateAvailability() {
        guard !selectedRover.availableCameras.contains(selectedCamera) else { return }
        selectedCamera = .all
    }
}
