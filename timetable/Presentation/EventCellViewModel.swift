//
//  UITableViewCellViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 02/12/21.
//

import Foundation

final class EventCellViewModel {
    
    let eventName: String
    let hasConflict: Bool
    let day: String
    let hour: String
    let title: String
    
    init(
        eventName: String,
        hasConflict: Bool,
        day: String,
        hour: String,
        title: String
    ) {
        self.eventName = eventName
        self.hasConflict = hasConflict
        self.day = day
        self.hour = hour
        self.title = title
    }
    
}
