import SwiftUI
import Database

public protocol HistoryListener: AnyObject {
    func chooseFilter(_ filter: Filter)
}

protocol HistoryViewNavigation: AnyObject {
    func goBack()
}

final class HistoryViewModel: ObservableObject {

    @Published var savedFilters: Array<Filter> = .init()
    @Published var showConfirmation: Bool = false
    @Published var selectedFilter: Filter? = nil

    @RealmRepositoryWrapper
    private var filtersRepository: RealmRepository<FilterEntity>
    private weak var navigation: HistoryViewNavigation?
    private weak var listener: HistoryListener?

    init(
        navigation: HistoryViewNavigation,
        listener: HistoryListener
    ) {
        self.navigation = navigation
        self.listener = listener
    }

    func fetchSavedFilters() {
        savedFilters = filtersRepository.getAll()
    }

    func goBackToDashboard() {
        navigation?.goBack()
    }

    func removeFilter() {
        guard let filter = selectedFilter else { return }
        do {
            try filtersRepository.remove(item: filter)
            savedFilters.removeAll(where: { $0.id == filter.id })
        } catch {
            print(error)
        }
    }

    func pickFilter() {
        guard let filter = selectedFilter else { return }
        listener?.chooseFilter(filter)
    }
}
