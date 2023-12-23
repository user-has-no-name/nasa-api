import Commons
import Database
import DependencyInjection
import NasaAPIService
import SwiftUI
import SecretsManager
import UICommons
import UserDefaultsManager

public protocol DashboardNavigation: AnyObject {
    func goToHistoryPage(_ listener: HistoryListener)
}

public final class DashboardViewModel: ObservableObject, LoaderPresentable {
    @Injected private var nasaService: NasaAPIService
    @Injected private var secretsManager: SecretsManager
    @Injected private var filterRepo: RealmRepository<FilterEntity>

    private var navigation: DashboardNavigation?

    @Published var showAlert: Bool = false
    @Published var selectedRow: RoverPhoto?
    @Published var showFullScreenImage: Bool = false
    @Published var popupConfig: PopupWithDatePickerModel?
    @Published var showRoverPicker: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var bottomSheetType: BottomSheetWithPickerType = .camera
    @Published var toastConfig: Toast?
    @Published var showEmptyState: Bool = false
    @Published public var loaderConfig: LoaderConfiguration?

    @Published var selectedFilter: Filter
    @Published var photos: MarsPhotos

    var currentPage: Int = 2

    public init(
        selectedFilter: Filter,
        photos: MarsPhotos,
        navigation: DashboardNavigation
    ) {
        self.selectedFilter = selectedFilter
        self.photos = photos
        self.navigation = navigation
    }

    func fetchPhotos() async {
        await showLoader()
        do {
            let fetchedPhotos: MarsPhotos = try await nasaService.getPhotos(
                using: .init(
                    roverName: selectedFilter.rover.abbreviation,
                    date: selectedFilter.date.toString(),
                    camera: selectedFilter.camera.abbreviation,
                    page: "\(currentPage)",
                    apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()
                )
            )
            await handleFetchedPhotos(fetchedPhotos)
        } catch {
            await handleFetchError(error)
        }
    }

    @MainActor
    private func handleFetchedPhotos(_ fetchedPhotos: MarsPhotos) {
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
    }

    @MainActor
    private func handleFetchError(_ error: Error) {
        toastConfig = .init(style: .error, message: "Error occurred \(error.localizedDescription)")
        showEmptyState = true
        removeLoader()
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

    func saveLastUsedFilter() {
        @UserDefaultsManager(.lastUsedFilter, defaultValue: nil) var lastUsedFilter: Data?
        do {
            lastUsedFilter = try JSONEncoder().encode(selectedFilter)
        } catch {
            toastConfig = .init(
                style: .error,
                message: "Could not save recently used filter. Error: \(error.localizedDescription)"
            )
        }
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
            pickerValues: selectedFilter.rover.availableCameras,
            selectedValue: selectedFilter.camera,
            listener: self
        )
    }

    func roverPickerViewModel() -> BottomSheetViewModel<RoverType> {
        .init(
            with: BottomSheetWithPickerType.rover.rawValue,
            pickerValues: RoverType.allCases,
            selectedValue: selectedFilter.rover,
            listener: self
        )
    }

    func showPopup() {
        popupConfig = .init(
            title: "Date",
            selectedDate: selectedFilter.date,
            onSaveTappedAction: { [weak self] date in
                self?.selectedFilter.date = date
                self?.closePopup()
            },
            onCancelTappedAction: { [weak self] in
                self?.closePopup()
            }
        )
    }

    @MainActor
    func saveFilter() async {
        do {
            let filterToSave: Filter = .init(
                id: .init(),
                rover: selectedFilter.rover,
                camera: selectedFilter.camera,
                date: selectedFilter.date
            )
            try await filterRepo.insert(item: filterToSave)
            toastConfig = .init(
                style: .success,
                message: "Filter successfully saved"
            )
        } catch {
            toastConfig = .init(
                style: .error,
                message: "Could not save filters. Error: \(error)"
            )
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
            selectedFilter.camera = cameraAbbreviation
        case let roverType as RoverType:
            selectedFilter.rover = roverType
        default:
            break
        }

        recalculateAvailability()
    }

    private func recalculateAvailability() {
        guard !selectedFilter.rover.availableCameras.contains(selectedFilter.camera) else { return }
        selectedFilter.camera = .all
    }
}

extension DashboardViewModel: HistoryListener {

    public func chooseFilter(_ filter: Filter) {
        selectedFilter = filter
    }
}
