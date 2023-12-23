import UIKit

public extension UINavigationController {

    func makeRootWith(_ viewController: UIViewController) {
        self.viewControllers.removeAll(where: { $0 != viewController })
    }
}
