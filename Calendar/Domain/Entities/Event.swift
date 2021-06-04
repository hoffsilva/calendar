//
//  Event.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

final class Event {
    
    let eventIdentifier: String
    let startDate: Date
    let endDate: Date
    let isAllDay: Bool
    let location: Location?
    let month: Month
    
    init(
        eventIdentifier: String,
        startDate: Date,
        endDate: Date,
        isAllDay: Bool,
        location: Location?,
        month: Month) {
        self.eventIdentifier = eventIdentifier
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
        self.location = location
        self.month = month
    }
    
}
