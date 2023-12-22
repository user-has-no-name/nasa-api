import Navigation
import UIKit
import Database

public struct DashboardDependency: Dependency {
    public let selectedFilter: Filter

    public init(selectedFilter: Filter) {
        self.selectedFilter = selectedFilter
    }
}

public final class DashboardCoordinator: Coordinator {
    public weak var parentCoordinator: (any Coordinator)?
    public var children: Array<any Coordinator> = .init()

    public var navigationController: UINavigationController
    public var dependency: DashboardDependency?

    public init(
        navigationController: UINavigationController,
        dependency: DashboardDependency
    ) {
        self.navigationController = navigationController
        self.dependency = dependency
        parentCoordinator = self
    }

    public func start() {
        navigateToDashboard(filter: dependency?.selectedFilter ?? .default())
    }

    private func navigateToDashboard(filter: Filter) {
        let dashboardView: DashboardView = .init(viewModel: .init(selectedFilter: filter, navigation: self))
        let hostingController: HostingController = .init(for: dashboardView)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(hostingController, animated: true)
    }
}

extension DashboardCoordinator: DashboardNavigation {

    public func goToHistoryPage(_ listener: HistoryListener) {
        let historyView = HistoryView()
            .environmentObject(
                HistoryViewModel(navigation: self, listener: listener)
            )
        let hostingController: HostingController = .init(for: historyView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

extension DashboardCoordinator: HistoryViewNavigation {

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
