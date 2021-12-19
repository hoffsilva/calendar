//
//  Month.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

struct Month: Hashable {
    
    let name: String
    let events: [Event]
    
    init(name: String, events: [Event]) {
        self.name = name
        self.events = events
    }
    
}
