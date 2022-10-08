//
//  Day.swift
//  timetable
//
//  Created by Hoff Silva on 07/06/21.
//

import Foundation

public struct Day: Hashable {
    
    public let number: String
    public var events: [Event]
    public var hours: [Hour]
    
    public init(number: String, events: [Event], hours: [Hour]) {
        self.number = number
        self.events = events
        self.hours = hours
    }
    
}
