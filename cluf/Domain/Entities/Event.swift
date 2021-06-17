//
//  Event.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

struct Event: Hashable {

    let startDate: Date
    let endDate: Date
    let isAllDay: Bool
    let location: Location?
    let month: Month
    let title: String
    let year: Int
    let day: Int
    
}
