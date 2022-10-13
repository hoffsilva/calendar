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
        .scope(.application)
        .implements(Coordinator.self)
        
        register { _, args in
            CustomLaunchScreenCoordinator(window: args("window"))
        }
        .scope(.application)
        .implements(Coordinator.self)
        
        register { _, args in
            DetailDayViewCoordinator(
                window: args("window"),
                from: args("viewController"),
                navigationController: args("navigationController"),
                day: args("day")
            )
        }
        .scope(.unique)
        .implements(Coordinator.self)
        
        register { _, args in
            AddEventViewCoordinator(
                window: args("window"),
                from: args("viewController"),
                navigationController: args("navigationController"),
                day: args("day")
            )
        }
        .scope(.unique)
        .implements(Coordinator.self)
        
    }
    
    public static func registerViews() {
        
        register {
            EventListViewController.loadFromNib()
        }
        .scope(.application)
        
        register {
            CustomLaunchScreen.loadFromNib()
        }
        .scope(.application)
        
        register { _, args in
            ErrorViewController.loadFromNib()
        }
        .scope(.application)
        
        register { _, args in
            DetailDayViewController.loadFromNib()
        }
        
        register { _, args in
            AddEventViewController.loadFromNib()
        }
        
    }
    
    public static func registerViewModels() {
        
        register { service, _ in
            EventViewModel(eventUseCase: service.resolve(GetEventsUseCase.self))
        }
        .scope(.application)
        
        register { _, args in
            ErrorViewModel(errorMessage: args.get("errorMessage"), allowCalendarAccess: args.get("allowCalendarAccess"))
        }
        .scope(.application)
        
        register { _, args in
            DaysEventsViewModel(day: args.get("day"))
        }
        .scope(.shared)
        
        register { service, args in
            AddEventViewModel(addEventUseCase: service.resolve(AddEventUseCase.self), currentDate: args.get("currentDate"))
        }
        .scope(.shared)
        
        
    }
    
    public static func registerUseCases() {
        
        register { service, _ in
            GetEventsUseCaseImp(getEventsRepository: service.resolve(GetEventsRepository.self))
        }
        .scope(.application)
        .implements(GetEventsUseCase.self)
        
        register { service, _ in
            AddEventUseCaseImp(addEventRepository: service.resolve(AddEventRepository.self))
        }
        .scope(.shared)
        .implements(AddEventUseCase.self)
        
    }
    
    public static func registerRepositories() {
        
        register { service, _ in
            GetEventsRepositoryImp(dataSource: service.resolve(EventsDataSource.self))
        }
        .scope(.application)
        .implements(GetEventsRepository.self)
        
        register { service, _ in
            AddEventRepositoryImp(calendarManager: self.resolve(CalendarManager.self))
        }
        .scope(.application)
        .implements(AddEventRepository.self)
        
    }
    
    public static func registerDataSources() {
        
        register {
            CalendarManagerImpl()
        }
        .scope(.application)
        .implements(CalendarManager.self)
        
        register {
            EventsDataSourceImp()
        }
        .scope(.application)
        .implements(EventsDataSource.self)
        
        
    }
    
}
