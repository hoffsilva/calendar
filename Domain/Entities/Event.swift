//
//  Event.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

public struct Event: Hashable {
    
   public let startDate: Date
   public let endDate: Date
   public let isAllDay: Bool
   public let location: String?
   public let title: String
   public let year: Int
   public let day: Int
   public let uuid = UUID()
    
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
