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
        window?.overrideUserInterfaceStyle = .dark
        configureWindow()
    }

    func configureWindow() {
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
    }
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        if previousTraitCollection.userInterfaceStyle == .dark {
            window?.overrideUserInterfaceStyle = .light
        } else {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
    

}

