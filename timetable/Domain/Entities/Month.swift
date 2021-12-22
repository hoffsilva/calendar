//
//  Month.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

struct Month: Hashable {
    
    var name: String
    var events: [Event]
    var month: Months
    let uuid = UUID()
    
    init(name: String, events: [Event], month: Months) {
        self.name = name
        self.events = events
        self.month = month
    }
    
}
