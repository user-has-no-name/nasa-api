//
//  SceneDelegate.swift
//  RedPlanet Viewer
//
//  Created by Oleksandr Zavazhenko on 18/12/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        setupRootView(for: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

private extension SceneDelegate {

    func setupRootView(for scene: UIWindowScene) {
        window = .init(windowScene: scene)
        let rootViewController: ViewController = .init()
        let navigationController: UINavigationController = .init(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
