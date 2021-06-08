//
//  Day.swift
//  Calendar
//
//  Created by Hoff Silva on 07/06/21.
//

import Foundation

struct Day: Hashable {
    
    let number: String
    let date: Date
    
    init(number: String, date: Date) {
        self.number = number
        self.date = date
    }
    
}
