//
//  DaysEventsViewModel.swift
//  Presentation
//
//  Created by Hoff Silva on 02/03/22.
//

import Domain
import Data

public struct HeaderData {
    public let dayOfWeek: String
    public let dayOfMonth: String
    public let month: String
}

public final class DaysEventsViewModel {
    
    private let day: Day
    
    public var listOfHour: (([Hour]) -> Void)?
    public var headerData: ((HeaderData) -> Void)?
    
    public init(day: Day) {
        self.day = day
    }
    
    public func loadData() {
        
        let set = Set(self.day.events.map { $0.startDate.getShortHour()})
        
        var hours = [Hour]()
        
        for hour in set {
            var a = Hour(name: hour, events: [])
            for event in day.events {
                if event.startDate.getShortHour() == a.name {
                    a.events.append(event)
                }
            }
            hours.append(a)
        }
        
        headerData?(
            HeaderData(
                dayOfWeek: day.events.first?.startDate.getDayOfWeek().capitalized ?? "",
                dayOfMonth: day.number,
                month: day.events.first?.startDate.getLongMonth() ?? ""
            )
        )
        
        listOfHour?(hours)
    }
    
}
