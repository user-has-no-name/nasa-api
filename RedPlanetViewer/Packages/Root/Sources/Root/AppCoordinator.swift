import UIKit
import Navigation
import RedPlanetViewerApp

public final class AppCoordinator: Coordinator {
    public weak var parentCoordinator: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let dashboardView: DashboardView = .init(viewModel: .init())
        let hostingController: HostingController = .init(for: dashboardView)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(hostingController, animated: true)
    }
}
