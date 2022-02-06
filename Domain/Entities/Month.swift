//
//  Month.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

public struct Month: Hashable {
    
    public var name: String
    public var days: [Day]
    public var month: Months
    let uuid = UUID()
    
    public init(name: String, days: [Day], month: Months) {
        self.name = name
        self.days = days
        self.month = month
    }
    
}
