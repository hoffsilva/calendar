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
    }
    
}

extension Resolver {
    
    public static func registerViews() {
        
        register {
//            GuideShopsListView()
        }
        
    }
    
}
