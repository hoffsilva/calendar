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
    func callAddEventView(of day: Day, from viewController: UIViewController, navigationController: TimeTableNavigationController)
}

public final class DetailDayViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController
    private var transitionOrigin: EventListViewController?
    private var detailDayViewController: DetailDayViewController?
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
        let detailDayViewModel = Resolver.resolve(DaysEventsViewModel.self, args: ["day": self.day])
        detailDayViewController = Resolver.resolve(DetailDayViewController.self, args: detailDayViewModel)
        detailDayViewController?.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
        detailDayViewController?.transitioningDelegate = transitionOrigin
        detailDayViewController?.modalPresentationStyle = .overFullScreen
        detailDayViewController?.detailDayViewControllerDelegate = self
        navigationController.viewControllers.first?.present(detailDayViewController!, animated: true, completion: nil)
    }
    
    public func showAddEventView(for day: Day) {
        self.detailDayViewCoordinatorDelegate?.callAddEventView(of: day, from: detailDayViewController!, navigationController: navigationController)
    }
    
    deinit {
        print("Bye \(#file)")
    }

}

extension DetailDayViewCoordinator: DetailDayViewControllerDelegate {
    
    func didTapOnCreateEventButton(for day: Day) {
        self.showAddEventView(for: day)
    }
    
}

