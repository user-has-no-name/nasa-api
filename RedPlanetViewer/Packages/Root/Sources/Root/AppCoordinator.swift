import UIKit
import Navigation
import RedPlanetViewerApp

public final class AppCoordinator: Coordinator {
    public weak var parentCoordinator: (any Coordinator)?
    public var children: Array<any Coordinator> = .init()
    public var navigationController: UINavigationController

    public var dependency: Dependency? = nil

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let preloaderCoordinator: PreloaderCoordinator = .init(navigationController: navigationController)
        preloaderCoordinator.start()
    }
}
