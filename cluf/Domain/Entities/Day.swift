//
//  Day.swift
//  Calendar
//
//  Created by Hoff Silva on 07/06/21.
//

import Foundation

struct Day: Hashable {
    
    let number: String
    var events: [Event]
    
    init(number: String, events: [Event]) {
        self.number = number
        self.events = events
    }
    
}
