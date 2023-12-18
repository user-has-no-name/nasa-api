import Dependencies
import DependencyInjection
import UIKit
import Root

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        registerDependencies()
        return setupCoordinator()
    }
}

private extension AppDelegate {

    func setupCoordinator() -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        let navigationController: UINavigationController = .init()
        appCoordinator = .init(navigationController: navigationController)
        guard let appCoordinator, let window else { return false }

        appCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }

    func registerDependencies() {
        DependenciesContainer.registerDependencies()
    }
}
