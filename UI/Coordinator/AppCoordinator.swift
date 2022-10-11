//
//  AppCoordinator.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import Domain
import UIKit


public final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: TimeTableNavigationController
    private var customLaunchScreenCoordinator: CustomLaunchScreenCoordinator?
    private var eventListViewCoordinator: EventListViewCoordinator?
    private var detailDayViewCoordinator: DetailDayViewCoordinator?
    
    public init(window: UIWindow) {
        self.window = window
        self.navigationController = TimeTableNavigationController()
    }
    
    public func start() {
        window.makeKeyAndVisible()
        showLaunchScreen()
    }
    
    private func showLaunchScreen() {
        self.customLaunchScreenCoordinator = Resolver.resolve(CustomLaunchScreenCoordinator.self, args: ["window": window])
        self.customLaunchScreenCoordinator?.customLaunchScreenCoordinatorDelegate = self
        self.customLaunchScreenCoordinator?.start()
    }
    
    private func showEventListView() {
        eventListViewCoordinator = Resolver.resolve(EventListViewCoordinator.self, args: ["window": window, "coordinator": self])
        eventListViewCoordinator?.eventListViewCoordinatorDelegate = self
        eventListViewCoordinator?.start()
    }
    
    private func showDetailOf(day: Day, from viewController: UIViewController) {
        detailDayViewCoordinator = Resolver.resolve(DetailDayViewCoordinator.self,
                                                    args: ["window": window,
                                                           "navigationController": navigationController,
                                                           "viewController": viewController,
                                                           "day": day]
        )
        detailDayViewCoordinator?.detailDayViewCoordinatorDelegate = self
        detailDayViewCoordinator?.start()
    }
    
}

extension AppCoordinator: CustomLaunchScreenCoordinatorDelegate {
    
    func didLoadEvents() {
        self.showEventListView()
    }
    
}

extension AppCoordinator: EventListViewCoordinatorDelegate {
    
    func showDetail(of day: Day, from viewController: UIViewController) {
        self.showDetailOf(day: day, from: viewController)
    }
    
}

extension AppCoordinator: DetailDayViewCoordinatorDelegate {
    
    
}
