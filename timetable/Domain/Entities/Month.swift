//
//  Month.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

struct Month: Hashable {
    
    var name: String
    var days: [Day]
    var month: Months
    let uuid = UUID()
    
    init(name: String, days: [Day], month: Months) {
        self.name = name
        self.days = days
        self.month = month
    }
    
}
