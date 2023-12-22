import Navigation
import UIKit
import Database

public final class PreloaderCoordinator: Coordinator {

    public var dependency: Dependency? = nil

    public weak var parentCoordinator: (any Coordinator)?
    public var children: Array<any Coordinator> = .init()

    public var navigationController: UINavigationController

    public init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }

    public func start() {
        let preloaderView = PreloaderView(viewModel: .init(navigation: self))
        let hostingController: HostingController = .init(for: preloaderView)
        navigationController.pushViewController(hostingController, animated: true)
    }

    private func navigateToDashboard(filter: Filter) {
        let dashboardCoordinator: DashboardCoordinator = .init(
            navigationController: navigationController,
            dependency: .init(selectedFilter: filter)
        )
        dashboardCoordinator.start()
    }
}

extension PreloaderCoordinator: PreloaderNavigation {

    public func goToDashboardFlow(filter: Filter) {
        navigateToDashboard(filter: filter)
    }
}
