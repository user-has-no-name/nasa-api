import SwiftUI
import UserDefaultsManager
import Database
import NasaAPIService
import DependencyInjection
import SecretsManager

public protocol PreloaderNavigation: AnyObject {
    func goToDashboardFlow(dependency: DashboardDependency)
}

public final class PreloaderViewModel: ObservableObject {
    @UserDefaultsManager(.lastUsedFilter, defaultValue: nil) private var lastUsedFilter: Data?
    @Injected private var nasaService: NasaAPIService
    @Injected private var secretsManager: SecretsManager

    private var navigation: PreloaderNavigation?

    public init(
        navigation: PreloaderNavigation
    ) {
        self.navigation = navigation
    }

    @MainActor
    func prefetchData() async {
        let filter: Filter = try! prefetchLastUsedFilter()

        do {
            let photos: MarsPhotos = try await nasaService.getPhotos(using: .init(
                roverName: filter.rover.abbreviation,
                date: filter.date.toString(),
                camera: filter.camera.abbreviation,
                page: "\(1)",
                apiKey: secretsManager.loadFromSecrets(using: .apiKey) ?? .init()))

            navigation?.goToDashboardFlow(dependency: .init(selectedFilter: filter, marsPhotos: photos))
        } catch {
            navigation?.goToDashboardFlow(dependency: .init(selectedFilter: filter, marsPhotos: .init(photos: .init())))
        }
    }

    private func prefetchLastUsedFilter() throws -> Filter {
        guard let lastUsedFilter: Data = lastUsedFilter else {
            return try configFilterForFirstTime()
        }
        let filter: Filter = try JSONDecoder().decode(Filter.self, from: lastUsedFilter)
        return filter
    }

    private func configFilterForFirstTime() throws -> Filter {
        let defaultFilter: Filter = .default()
        lastUsedFilter = try JSONEncoder().encode(defaultFilter)
        return defaultFilter
    }
}
