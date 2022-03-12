//
//  Date+Extensions.swift
//  timetable
//
//  Created by Hoff Silva on 06/06/21.
//

import Foundation

public extension Date {
    
    var time: Time {
        return Time(self)
    }
    
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    func getIntDay() -> Int {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd"
        return Int(formatter.string(from: self)) ?? -1
    }
    
    func getShortMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    
    func getLongMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    func getShortHour() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "h a"
        return formatter.string(from: self)
    }
    
    func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func getIntHour() -> Int {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return Int(formatter.string(from: self)) ?? 0
    }
    
    func getYear() -> Int {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "YYYY"
        return Int(formatter.string(from: self)) ?? 0
    }
    
}
