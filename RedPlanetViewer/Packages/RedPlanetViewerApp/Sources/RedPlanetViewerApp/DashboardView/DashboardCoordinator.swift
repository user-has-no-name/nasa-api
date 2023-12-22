import Navigation
import UIKit

public final class DashboardCoordinator: Coordinator {

    public weak var parentCoordinator: Coordinator?
    public var children: Array<Coordinator> = .init()

    public var navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigateToDashboard()
    }

    private func navigateToDashboard() {
        let dashboardView: DashboardView = .init(viewModel: .init(navigation: self))
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
