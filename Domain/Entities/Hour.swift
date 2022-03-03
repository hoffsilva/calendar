//
//  Hour.swift
//  Domain
//
//  Created by Hoff Silva on 02/03/22.
//

import Foundation

public struct Hour: Hashable {
    
    public var name: String
    public var events: [Event]
    let uuid = UUID()
    
    public init(name: String, events: [Event]) {
        self.name = name
        self.events = events
    }
    
    
}
