//
//  DetailDayViewCoordinator.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-11.
//

import UIKit
import Presentation
import Domain

protocol DetailDayViewCoordinatorDelegate: AnyObject {
    
}

public final class DetailDayViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController
    private var transitionOrigin: EventListViewController?
    private var day: Day
    
    weak var detailDayViewCoordinatorDelegate: DetailDayViewCoordinatorDelegate?
    
    public init(window: UIWindow,
                from transitionOrigin: UIViewController,
                navigationController: TimeTableNavigationController,
                day: Day) {
        self.window = window
        self.navigationController = navigationController
        self.transitionOrigin = transitionOrigin as? EventListViewController
        self.day = day
    }
    
    public func start() {
        let detailDayViewModel = Resolver.resolve(DaysEventsViewModel.self, args: ["day": day])
        let detailDayViewController = Resolver.resolve(DetailDayViewController.self, args: detailDayViewModel)
        detailDayViewController.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
        detailDayViewController.transitioningDelegate = transitionOrigin
        detailDayViewController.modalPresentationStyle = .overFullScreen
        navigationController.viewControllers.first?.present(detailDayViewController, animated: true, completion: nil)
    }
    
    public func showAddEventView(of day: Day) {
        let detailDayViewModel = Resolver.resolve(DaysEventsViewModel.self, args: ["day": day])
        let detailDayViewController = Resolver.resolve(DetailDayViewController.self, args: detailDayViewModel)
        detailDayViewController.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
        detailDayViewController.transitioningDelegate = detailDayViewController
        detailDayViewController.modalPresentationStyle = .overFullScreen
        navigationController.viewControllers.first?.present(detailDayViewController, animated: true, completion: nil)
    }

}

extension DetailDayViewCoordinator: DetailDayViewControllerDelegate {
    
    func didTapOnCreateEventButton() {
        
    }
    
}

