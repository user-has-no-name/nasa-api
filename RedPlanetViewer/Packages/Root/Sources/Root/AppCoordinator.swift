import UIKit
import Navigation

public final class AppCoordinator: Coordinator {
    public weak var parentCoordinator: Coordinator?
    public var children: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        #warning("Implement as a next step")
    }
}
