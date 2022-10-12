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
    
    private var day: Day
    
    public var listOfHour: (([Hour]) -> Void)?
    public var headerData: ((HeaderData) -> Void)?
    
    public init(day: Day) {
        self.day = day
    }
    
    public func loadData() {
        
        for (index, hour) in day.hours.enumerated() {
            for event in day.events {
                if event.startDate.getShortHour() == hour.name {
                    day.hours[index].events.append(event)
                }
            }
        }
        
        headerData?(
            HeaderData(
                dayOfWeek: day.events.first?.startDate.getDayOfWeek().capitalized ?? "",
                dayOfMonth: day.number,
                month: day.events.first?.startDate.getLongMonth() ?? ""
            )
        )
        
        listOfHour?(day.hours)
    }
    
    public func getDay() -> Day {
        self.day
    }
    
}
