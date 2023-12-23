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
        let preloaderView: PreloaderView = .init(viewModel: .init(navigation: self))
        let hostingController: HostingController = .init(for: preloaderView)
        navigationController.pushViewController(hostingController, animated: true)
    }

    private func navigateToDashboard(with dependency: DashboardDependency) {
        let dashboardCoordinator: DashboardCoordinator = .init(
            navigationController: navigationController,
            dependency: dependency
        )
        dashboardCoordinator.start()
    }
}

extension PreloaderCoordinator: PreloaderNavigation {

    public func goToDashboardFlow(dependency: DashboardDependency) {
        navigateToDashboard(with: dependency)
    }
}
