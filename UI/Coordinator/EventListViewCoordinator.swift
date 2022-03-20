//
//  EventListViewCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import UIKit
import Presentation
import Domain

public final class EventListViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController?
    private var eventListViewController: EventListViewController?
    @WeakLazyInjected private var delegate: Coordinator?
    
    public init(window: UIWindow) {
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
    
    public func showDetail(of day: Day, from viewController: UIViewController) {
        let detailDayViewModel = Resolver.resolve(DaysEventsViewModel.self,args: ["day": day])
        let detailDayViewController = Resolver.resolve(DetailDayViewController.self, args: detailDayViewModel)
        guard let eventListViewController = viewController as? EventListViewController else {
            return
        }
        detailDayViewController.transitioningDelegate = eventListViewController
        detailDayViewController.modalPresentationStyle = .custom
        navigationController?.viewControllers.first?.present(detailDayViewController, animated: true, completion: nil)
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
