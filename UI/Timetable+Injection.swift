//
//  DI.swift
//  timetable
//
//  Created by Hoff Silva on 24/11/21.
//

import Presentation
import Data
import Domain
import Foundation

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        Resolver.defaultScope = .shared
        registerCoordinators()
        registerViews()
        registerViewModels()
        registerUseCases()
        registerRepositories()
        registerDataSources()
    }
    
}

extension Resolver {
    
    public static func registerCoordinators() {
        
        register { _, args in
            EventListViewCoordinator(window: args("window"))
        }
        .implements(Coordinator.self)
        
        register { _, args in
            CustomLaunchScreenCoordinator(window: args("window"))
        }
        .implements(Coordinator.self)
        
        register { _, args in
            DetailDayViewCoordinator(
                window: args("window"),
                from: args("viewController"),
                navigationController: args("navigationController"),
                day: args("day")
            )
        }
        .implements(Coordinator.self)
        
        register { _, args in
            AddEventViewCoordinator(
                window: args("window"),
                from: args("viewController"),
                navigationController: args("navigationController"),
                day: args("day")
            )
        }
        .implements(Coordinator.self)
        
    }
    
    public static func registerViews() {
        
        register {
            EventListViewController.loadFromNib()
        }
        
        
        register {
            CustomLaunchScreen.loadFromNib()
        }
        
        
        register { _, args in
            ErrorViewController.loadFromNib()
        }
        
        
        register { _, args in
            DetailDayViewController.loadFromNib()
        }
        
        
        register { _, args in
            AddEventViewController.loadFromNib()
        }
        
        
    }
    
    public static func registerViewModels() {
        
        register {
            EventViewModel(eventUseCase: resolve())
        }
        
        register { _, args in
            ErrorViewModel(errorMessage: args.get("errorMessage"), allowCalendarAccess: args.get("allowCalendarAccess"))
        }
        
        register { _, args in
            DaysEventsViewModel(day: args.get("day"))
        }
        
        register { service, args in
            AddEventViewModel(addEventUseCase: service.resolve(AddEventUseCase.self), currentDate: args.get("currentDate"))
        }
        
    }
    
    public static func registerUseCases() {
        
        register { service, _ in
            GetEventsUseCaseImp(getEventsRepository: service.resolve(GetEventsRepository.self))
        }
        .implements(GetEventsUseCase.self)
        
        register { service, _ in
            AddEventUseCaseImp(addEventRepository: service.resolve(AddEventRepository.self))
        }
        .implements(AddEventUseCase.self)
        
    }
    
    public static func registerRepositories() {
        
        register { service, _ in
            GetEventsRepositoryImp(dataSource: service.resolve(EventsDataSource.self))
        }
        .implements(GetEventsRepository.self)
        
        register { service, _ in
            AddEventRepositoryImp(calendarManager: self.resolve(CalendarManager.self))
        }
        .implements(AddEventRepository.self)
        
    }
    
    public static func registerDataSources() {
        
        register {
            CalendarManagerImpl()
        }
        .implements(CalendarManager.self)
        
        register {
            EventsDataSourceImp()
        }
        .implements(EventsDataSource.self)
        
        
    }
    
}
