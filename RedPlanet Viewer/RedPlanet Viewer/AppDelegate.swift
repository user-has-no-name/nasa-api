//
//  AppDelegate.swift
//  RedPlanet Viewer
//
//  Created by Oleksandr Zavazhenko on 18/12/2023.
//

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
        setupCoordinator()
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
}
