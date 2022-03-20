//
//  SceneDelegate.swift
//  testes
//
//  Created by Hoff Silva on 27/09/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureWindow()
    }

    func configureWindow() {
        switch UserDefaults.standard.integer(forKey: "overrideUserInterfaceStyle") {
        case UIUserInterfaceStyle.dark.rawValue:
            window?.overrideUserInterfaceStyle = .dark
        case UIUserInterfaceStyle.light.rawValue:
            window?.overrideUserInterfaceStyle = .light
        default:
            window?.overrideUserInterfaceStyle = .dark
        }
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
    }
}

