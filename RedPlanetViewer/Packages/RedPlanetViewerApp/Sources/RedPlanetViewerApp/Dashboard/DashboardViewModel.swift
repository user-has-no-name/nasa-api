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
    @Published var selectedRover: RoverType = .defaultValue
    @Published var selectedCamera: RoverCameraAbbreviation = .defaultValue

    @Published var loading: Bool = false
    @Published var selectedDate: Date = .init()
    @Published var photos: MarsPhotos = .init(photos: .init())

    public init() {}

    @MainActor
    func fetchPhotos() async {
        loading = true
        do {
            photos = try await nasaService.getPhotosFromRover(
                using: .init(
                    roverName: selectedRover.rawValue,
                    date: "2015-6-3",
                    camera: selectedCamera.rawValue,
                    apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()
                )
            )
            print(photos)
            loading = false
        } catch {
            loading = false
        }
    }

    func showBottomSheetPicker(of type: BottomSheetWithPickerType) {
        showCameraPicker = type == .camera
        showRoverPicker = type == .rover
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

    func recalculateAvailability() {
        guard !selectedRover.availableCameras.contains(selectedCamera) else { return }
        selectedCamera = .all
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

    func closePopup() {
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
}
