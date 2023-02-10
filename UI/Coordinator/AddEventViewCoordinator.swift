//
//  AddEventViewCoordinator.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//


import UIKit
import Presentation
import Domain
import Data

protocol AddEventViewCoordinatorDelegate: AnyObject {
    func cleanCoordinator()
}

public final class AddEventViewCoordinator: Coordinator {
 
    private let window: UIWindow
    private var navigationController: TimeTableNavigationController
    private var transitionOrigin: DetailDayViewController?
    private var addEventViewController: AddEventViewController?
    private var addEventViewModel: AddEventViewModel?
    private var day: Day
    
    weak var addEventViewCoordinatorDelegate: AddEventViewCoordinatorDelegate?
    
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
        let calendarManager = CalendarManagerImpl()
        let addEventRepository = AddEventRepositoryImp(calendarManager: calendarManager)
        let addEventUseCase = AddEventUseCaseImp(addEventRepository: addEventRepository)
        addEventViewModel = AddEventViewModel(addEventUseCase: addEventUseCase, currentDate: day.date)
        addEventViewController = AddEventViewController.loadFromNib()
        addEventViewController?.addEventViewModel = self.addEventViewModel
        addEventViewController?.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
        addEventViewController?.transitioningDelegate = addEventViewController
        addEventViewController?.modalPresentationStyle = .overFullScreen
        addEventViewController?.addEventViewControllerDelegate = self
        navigationController.presentedViewController?.present(addEventViewController!, animated: true, completion: nil)
    }
    
    private func dismissAddEventViewController() {
        self.addEventViewController?.dismiss(animated: true, completion: { [weak self] in
            self?.addEventViewCoordinatorDelegate?.cleanCoordinator()
        })
    }
    
    private func showStartsAtScreen() {
        
    }
    
    deinit {
        print("Bye \(#file)")
    }

}

extension AddEventViewCoordinator: AddEventViewControllerDelegate {
    func didTapOnCancelButton() {
        dismissAddEventViewController()
    }
    
    func didTapOnStartField() {
        showStartsAtScreen()
    }
    
    func didTapOnEndField() {
        
    }
    
}
