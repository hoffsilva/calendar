//
//  Event.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

public enum AcceptanceAnswer: Int {
    case notAnswered = 0
    case accepted = 1
    case tentative = 2
}

public struct Event: Hashable {
    
    public let startDate: Date
    public let endDate: Date
    public let isAllDay: Bool
    public let location: String?
    public let title: String
    public let year: Int
    public let day: Int
    public let uuid = UUID()
    public let acceptanceAnswer: AcceptanceAnswer
    
    public init(startDate: Date, endDate: Date, isAllDay: Bool, location: String?, title: String, year: Int, day: Int, acceptanceAnswer: AcceptanceAnswer) {
        self.startDate = startDate
        self.endDate = endDate
        self.isAllDay = isAllDay
        self.location = location
        self.title = title
        self.year = year
        self.day = day
        self.acceptanceAnswer = acceptanceAnswer
    }
}
