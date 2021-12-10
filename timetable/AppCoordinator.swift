//
//  AppCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import Resolver
import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.makeKeyAndVisible()
        showLaunchScreen()
    }
    
    private func showLaunchScreen() {
        let customLaunchScreen = Resolver.resolve(CustomLaunchScreen.self)
        customLaunchScreen.delegate = self
        self.window.rootViewController = customLaunchScreen
    }
    
    private func showEventListView() {
        let eventListViewCoordinator = Resolver.resolve(EventListViewCoordinator.self, args: ["window": window, "coordinator": self])
        eventListViewCoordinator.start()
    }
    
}

extension AppCoordinator: CustomLaunchScreenDelegate {
    
    func finishDidLoad() {
        self.showEventListView()
    }
    
}
