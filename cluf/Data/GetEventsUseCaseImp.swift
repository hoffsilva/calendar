//
//  GetEventsUseCaseImp.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation
import SwiftUI

final class GetEventsUseCaseImp: GetEventsUseCase {
    
    let repository = GetEventsRepositoryImp(dataSource: EventsDataSourceImp())
    
    
    func getEvents(from year: Int, completion: @escaping ((Result<[SectionForEvents], Error>) -> Void)) {
        repository.getEvents(from: year) { result in
            switch result {
            case .success(let events):
                completion(.success(self.createSections(from: events, for: year)))
            case .failure: ()
            }
        }
    }
    
    enum CalendarError: Error {
        case generic
    }
    
    private func createSections(from events: [Event], for year: Int) -> [SectionForEvents] {
        var sections = [SectionForEvents]()
        var days = [Day]()
        var stringDays: Set<String> = Set()
        for month in 1...12 {
            let filteredEvents = getEvents(events: events, from: month)
            for day in 1...getDaysOf(month: month, and: year)  {
                for event in filteredEvents {
                    if event.startDate.getDay().prefix(1) == "0" {
                        if event.startDate.getDay() == "0\(day)" {
                            stringDays.insert(event.startDate.getDay())
                        }
                    } else {
                        if event.startDate.getDay() == "\(day)" {
                            stringDays.insert(event.startDate.getDay())
                        }
                    }
                }
            }
            
            
            
            for day in stringDays {
                var dayWithEvents = Day(number: day, events: [Event]())
                for event in filteredEvents {
                    if event.startDate.getDay() == day {
                        dayWithEvents.events.append(event)
                    }
                }
                days.append(dayWithEvents)
            }
            
            if let nameOfMont = filteredEvents.first?.month.name {
                let section = SectionForEvents(
                    id: nil,
                    month: nameOfMont,
                    days: days,
                    stringDays: stringDays.sorted(),
                    events: filteredEvents
                )
                sections.append(section)
            }
            
            
        }
        return sections
    }
    
    private func getEvents(events: [Event], from month: Int) -> [Event] {
        events.filter { event in
            event.month.number == month
        }
    }
    
    private func getDaysOf(month: Int, and year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        let calendar = NSCalendar.current
        guard let date = calendar.date(from: dateComponents) else { return 0 }
        
        let range = calendar.range(of: .day, in: .month, for: date)
        
        return range!.count
        
    }
    
}
