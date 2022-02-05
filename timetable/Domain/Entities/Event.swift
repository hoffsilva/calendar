//
//  Event.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

public struct Event: Hashable {
    
    let startDate: Date
    let endDate: Date
    let isAllDay: Bool
    let location: String?
    let title: String
    let year: Int
    let day: Int
    let uuid = UUID()
    
    public init(startDate: Date, endDate: Date, isAllDay: Bool, location: String?, title: String, year: Int, day: Int) {
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
        self.location = location
        self.title = title
        self.year = year
        self.day = day
    }
}
