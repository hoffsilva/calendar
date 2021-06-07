//
//  Date+Extensions.swift
//  Calendar
//
//  Created by Hoff Silva on 06/06/21.
//

import Foundation

extension Date {
    
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
}
