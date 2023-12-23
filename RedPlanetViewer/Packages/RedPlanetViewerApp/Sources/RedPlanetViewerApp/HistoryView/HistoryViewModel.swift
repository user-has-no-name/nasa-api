import SwiftUI
import Database
import DependencyInjection
import UICommons

public protocol HistoryListener: AnyObject {
    func chooseFilter(_ filter: Filter)
}

protocol HistoryViewNavigation: AnyObject {
    func goBack()
}

final class HistoryViewModel: ObservableObject {

    @Injected private var filtersRepository: RealmRepository<FilterEntity>
    @Published var savedFilters: Array<Filter> = .init()
    @Published var showConfirmation: Bool = false
    @Published var selectedFilter: Filter? = nil
    @Published var toast: Toast?

    private weak var navigation: HistoryViewNavigation?
    private weak var listener: HistoryListener?

    init(
        navigation: HistoryViewNavigation,
        listener: HistoryListener
    ) {
        self.navigation = navigation
        self.listener = listener
    }

    @MainActor
    func fetchSavedFilters() {
        savedFilters = filtersRepository.getAll()
    }

    func pickFilter() {
        guard let filter = selectedFilter else { return }
        listener?.chooseFilter(filter)
    }

    func removeFilter() {
        guard let filter = selectedFilter else { return }
        Task { @MainActor in
            do {
                try await filtersRepository.remove(item: filter)
                savedFilters.removeAll(where: { $0.id == filter.id })
            } catch {
                toast = .init(style: .warning, message: "Filter removed successfully")
            }
        }
    }

    func goBackToDashboard() {
        navigation?.goBack()
    }
}
