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
    }
    
}

extension Resolver {
    
    public static func registerCoordinators() {
        
        register { _, args in
            EventListViewCoordinator(window: args("window"))
        }
        .scope(.application)
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
        .scope(.application)
        
    }
    
    public static func registerViewModels() {
        register {
            EventViewModel(eventUseCase: Resolver.resolve(GetEventsUseCase.self))
        }
        .scope(.application)
        
        register { _, args in
            ErrorViewModel(errorMessage: args.get("errorMessage"), allowCalendarAccess: args.get("allowCalendarAccess"))
        }
        .scope(.application)
        
        register { _, args in
            DaysEventsViewModel(day: args.get("day"))
        }
        .scope(.application)
    }
    
    public static func registerUseCases() {
        
        register {
            GetEventsUseCaseImp()
        }
        .scope(.application)
        .implements(GetEventsUseCase.self)
        
    }
    
}
