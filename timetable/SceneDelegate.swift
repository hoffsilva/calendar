//
//  SceneDelegate.swift
//  testes
//
//  Created by Hoff Silva on 27/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var navigationController = UINavigationController(rootViewController: EventView())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        configureWindow()
    }

    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

