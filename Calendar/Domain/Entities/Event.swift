//
//  Event.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//


final class Event {
    
    let eventIdentifier: String
    let startDate: String
    let endDate: String
    let isAllDay: Bool
    let location: Location?
    
    init(eventIdentifier: String, startDate: String, endDate: String, isAllDay: Bool, location: Location?) {
        self.eventIdentifier = eventIdentifier
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
        self.location = location
    }
    
}
