//
//  EventListViewCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import Resolver
import UIKit


final class EventListViewCoordinator: Coordinator {
 
    private let window: UIWindow
    @WeakLazyInjected private var delegate: Coordinator?
    
    internal init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = TimeTableNavigationController(rootViewController: Resolver.resolve(EventListViewController.self))
        self.window.rootViewController = navigationController
    }
    
}
