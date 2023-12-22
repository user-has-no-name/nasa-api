import UIKit
import Navigation
import RedPlanetViewerApp

public final class AppCoordinator: Coordinator {
    public weak var parentCoordinator: Coordinator?
    public var children: Array<Coordinator> = .init()
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let dashboardCoordinator: DashboardCoordinator = .init(navigationController: navigationController)
        dashboardCoordinator.start()
    }
}
