//
//  DI.swift
//  timetable
//
//  Created by Hoff Silva on 24/11/21.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerViews()
        registerViewModels()
        registerUseCases()
    }
    
}

extension Resolver {
    
    public static func registerViews() {
        
        register {
            EventListView()
        }
        
    }
    
    public static func registerViewModels() {
        
        register {
            EventViewModel(eventUseCase: GetEventsUseCaseImp())
        }
        
    }
    
    public static func registerUseCases() {
        
        register {
            GetEventsUseCaseImp()
        }.implements(GetEventsUseCase.self)
        
    }
    
}
