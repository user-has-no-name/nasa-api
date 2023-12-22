import Commons
import Database
import DependencyInjection
import SwiftUI
import NasaAPIService
import SecretsManager
import UICommons

public protocol DashboardNavigation: AnyObject {
    func goToHistoryPage(_ listener: HistoryListener)
}

public final class DashboardViewModel: ObservableObject, LoaderPresentable {
    @Injected private var nasaService: NasaAPIService
    @Injected private var secretsManager: SecretsManager

    private  var navigation: DashboardNavigation?

    @Published var showAlert: Bool = false
    @Published var selectedRow: RoverPhoto?
    @Published var showFullScreenImage: Bool = false
    @Published var popupConfig: PopupWithDatePickerModel?
    @Published var showRoverPicker: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var bottomSheetType: BottomSheetWithPickerType = .camera
    @Published var toastConfig: Toast?
    @Published var showEmptyState: Bool = false

    @Published var selectedRover: RoverType = .defaultValue
    @Published var selectedCamera: RoverCameraAbbreviation = .defaultValue
    @Published var selectedDate: Date = .init()

    @Published var photos: MarsPhotos = .init(photos: .init())

    @Published public var loaderConfig: LoaderConfiguration?
    @RealmRepositoryWrapper
    var filterRepo: RealmRepository<FilterEntity>

    var currentPage: Int = 1

    var selectedValues: Array<AnyHashable> {[
        selectedRover,
        selectedCamera,
        selectedDate
    ]}

    public init(
        navigation: DashboardNavigation
    ) {
        self.navigation = navigation
    }

    @MainActor
    func fetchPhotos() async {
        showLoader()
        do {
            let fetchedPhotos: MarsPhotos = try await nasaService.getPhotosFromRover(
                using: .init(
                    roverName: selectedRover.abbreviation,
                    date: selectedDate.toString(),
                    camera: selectedCamera.abbreviation,
                    page: "\(currentPage)",
                    apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()
                )
            )

            if !fetchedPhotos.photos.isEmpty {
                photos.photos.append(contentsOf: fetchedPhotos.photos)
                currentPage += 1
            } else {
                guard currentPage != 1 else {
                    showEmptyState = true
                    removeLoader()
                    return
                }

                toastConfig = .init(style: .info, message: "There is no more images")
            }
            removeLoader()
        } catch {
            toastConfig = .init(style: .error, message: "Error occurred \(error.localizedDescription)")
            showEmptyState = true
            removeLoader()
        }
    }

    func loadMoreIfNeeded(lastAppearedCard: RoverPhoto) async {
        guard photos.photos.last?.id == lastAppearedCard.id else { return }
        await fetchPhotos()
    }

    func clearResults() {
        showEmptyState = false
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

    func saveFilter() {
        do { 
            try filterRepo.insert(item: .init(
                id: .init(),
                rover: selectedRover.rawValue,
                camera: selectedCamera.rawValue,
                date: selectedDate
            ))

            toastConfig = .init(style: .success, message: "Filter successfully saved")
        } catch {
            toastConfig = .init(style: .error, message: "Could not save filters. Error: \(error)")
        }
    }

    func goToHistoryPage() {
        navigation?.goToHistoryPage(self)
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

extension DashboardViewModel: HistoryListener {

    public func chooseFilter(_ filter: Filter) {
        selectedRover = .init(rawValue: filter.rover) ?? .curiosity
        selectedCamera = .init(rawValue: filter.camera) ?? .all
        selectedDate = filter.date
    }
}