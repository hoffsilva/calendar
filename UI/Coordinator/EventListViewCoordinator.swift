//
//  EventListViewCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import UIKit
import Presentation
import Domain

protocol EventListViewCoordinatorDelegate: AnyObject {
    func showDetail(of day: Day, from viewController: UIViewController, navigationController: TimeTableNavigationController)
}

public final class EventListViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController?
    private var eventListViewController: EventListViewController?
    
    weak var eventListViewCoordinatorDelegate: EventListViewCoordinatorDelegate?
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        eventListViewController = Resolver.resolve(EventListViewController.self)
        eventListViewController?.delegate = self
        navigationController = TimeTableNavigationController(rootViewController: eventListViewController ?? UIViewController(), window: self.window)
        self.window.rootViewController = navigationController
    }
    
    private func showErrorViewController(with errorMessage: String, and calendarAccessGranted: Bool) {
        let errorViewModel: ErrorViewModel = Resolver.resolve(args: [
            "errorMessage": errorMessage,
            "allowCalendarAccess": calendarAccessGranted
        ])
        let errorViewController = Resolver.resolve(ErrorViewController.self, args: errorViewModel)
        errorViewController.modalPresentationStyle = .overCurrentContext
        errorViewController.delegate = self
        navigationController?.viewControllers.first?.present(errorViewController, animated: true, completion: nil)
    }
    
    private func showDetail(of day: Day, from viewController: UIViewController) {
        self.eventListViewCoordinatorDelegate?.showDetail(of: day, from: viewController, navigationController: self.navigationController!)
    }

}

extension EventListViewCoordinator: EventListViewControllerDelegate {
    
    public func didTapToDetail(day: Day, from viewController: UIViewController) {
        self.showDetail(of: day, from: viewController)
    }
    
    
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
