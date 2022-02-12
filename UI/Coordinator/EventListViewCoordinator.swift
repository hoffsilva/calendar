//
//  EventListViewCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import Resolver
import UIKit
import Presentation

public final class EventListViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: UINavigationController?
    private var eventListViewController: EventListViewController?
    @WeakLazyInjected private var delegate: Coordinator?
    
    public  init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        eventListViewController = Resolver.resolve(EventListViewController.self)
        eventListViewController?.delegate = self
        navigationController = TimeTableNavigationController(rootViewController: eventListViewController ?? UIViewController())
        self.window.rootViewController = navigationController
    }
    
    public func showErrorViewController(with errorMessage: String, and calendarAccessGranted: Bool) {
        let errorViewModel: ErrorViewModel = Resolver.resolve(args: [
            "errorMessage": errorMessage,
            "allowCalendarAccess": calendarAccessGranted
        ])
        let errorViewController = Resolver.resolve(ErrorViewController.self, args: errorViewModel)
        errorViewController.modalPresentationStyle = .overCurrentContext
        errorViewController.delegate = self
        navigationController?.viewControllers.first?.present(errorViewController, animated: true, completion: nil)
    }

}

extension EventListViewCoordinator: EventListViewControllerDelegate {
    
    public func didLoadDataWithAccessNotGranted() {
        showErrorViewController(with: Localizable.descriptionOfErrorScreenWhenCalendarAccessNotGranted(), and: false)
    }
    
}

extension EventListViewCoordinator: ErrorViewControllerDelegate {
    
    public func didTopOnAllowCalendarAccessButton() {
        navigationController?.viewControllers.last?.dismiss(animated: true, completion: {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
    }
    
    public func didTopOnCloseButton() {
        navigationController?.viewControllers.last?.dismiss(animated: true, completion: {
            self.eventListViewController?.viewDidLoad()
        })
    }
    
}
