import SwiftUI
import UserDefaultsManager
import Database

public protocol PreloaderNavigation: AnyObject {
    func goToDashboardFlow(filter: Filter)
}

public final class PreloaderViewModel: ObservableObject {
    @UserDefaultsManager(.lastUsedFilter, defaultValue: nil) private var lastUsedFilter: Data?
    @RealmRepositoryWrapper
    private var filterRepository: RealmRepository<FilterEntity>

    private var navigation: PreloaderNavigation?

    public init(
        navigation: PreloaderNavigation
    ) {
        self.navigation = navigation
    }

    func prefetchData() {
        let filter = try! prefetchLastUsedFilter()
        navigation?.goToDashboardFlow(filter: filter)
    }

    func prefetchLastUsedFilter() throws -> Filter {
        guard let lastUsedFilter: Data = lastUsedFilter else {
            return try configFilterForFirstTime()
        }
        let filter: Filter = try JSONDecoder().decode(Filter.self, from: lastUsedFilter)
        return filter
    }

    private func configFilterForFirstTime() throws -> Filter {
        let defaultFilter: Filter = .default()
        try filterRepository.insert(item: defaultFilter)
        lastUsedFilter = try JSONEncoder().encode(defaultFilter)
        return defaultFilter
    }
}
