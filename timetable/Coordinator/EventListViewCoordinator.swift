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
    private var navigationController: UINavigationController?
    @WeakLazyInjected private var delegate: Coordinator?
    
    internal init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let eventListViewController = Resolver.resolve(EventListViewController.self)
        eventListViewController.delegate = self
        navigationController = TimeTableNavigationController(rootViewController: eventListViewController)
        self.window.rootViewController = navigationController
    }

}

extension EventListViewCoordinator: EventListViewControllerDelegate {
    
    func didLoadDataWithAccessNotGranted() {
        let errorViewController = Resolver.resolve(ErrorViewController.self, args: Localizable.descriptionOfErrorScreen)
        navigationController?.show(errorViewController, sender: nil)
    }
    
}
