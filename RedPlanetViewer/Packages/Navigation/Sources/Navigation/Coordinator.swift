import UIKit

public protocol Dependency {

}

public protocol Coordinator: AnyObject {
    associatedtype Dependency
    var parentCoordinator: (any Coordinator)? { get set }
    var children: Array<any Coordinator> { get set }
    var dependency: Dependency? { get set }
    var navigationController : UINavigationController { get set }

    func start()
}
