//
//  AddEventViewCoordinator.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//


import UIKit
import Presentation
import Domain

protocol AddEventViewCoordinatorDelegate: AnyObject {
    
}

public final class AddEventViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController
    private var transitionOrigin: DetailDayViewController?
    private var day: Day
    
    weak var detailDayViewCoordinatorDelegate: DetailDayViewCoordinatorDelegate?
    
    public init(window: UIWindow,
                from transitionOrigin: UIViewController,
                navigationController: TimeTableNavigationController,
                day: Day) {
        self.window = window
        self.navigationController = navigationController
        self.transitionOrigin = transitionOrigin as? DetailDayViewController
        self.day = day
    }
    
    public func start() {
//        let addEventUseCase
//        let detailDayViewModel = Resolver.resolve(AddEventViewModel.self, args: ["day": day])
//        let detailDayViewController = Resolver.resolve(AddEventViewController.self, args: detailDayViewModel)
//        detailDayViewController.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
//        detailDayViewController.transitioningDelegate = transitionOrigin
//        detailDayViewController.modalPresentationStyle = .overFullScreen
//        navigationController.viewControllers.first?.present(detailDayViewController, animated: true, completion: nil)
    }
    
    public func showAddEventView(for day: Day) {
        
    }

}
