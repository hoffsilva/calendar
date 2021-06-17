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
    
    private var date = Date()

    func getEvents(from year: Int, completion: @escaping ((Result<[SectionForEvents], Error>) -> Void)) {
        repository.requestAccess { granted in
            if granted {
                self.repository.getEvents(from: year) { result in
                    switch result {
                    case .success(let events):
                        completion(.success(self.createSections(from: events, for: year)))
                    case .failure: ()
                    }
                }
            }
        }
    }
    
    enum CalendarError: Error {
        case generic
    }
    
    private func createSections(from events: [Event], for year: Int) -> [SectionForEvents] {
        var sections = [SectionForEvents]()
        
        for month in 1...12 {
            var days = [Day]()
            var stringDays: Set<String> = Set()
            let filteredEventsByMonth = getEvents(events: events, from: month)
            for day in 1...getDaysOf(month: month, and: year)  {
                for event in filteredEventsByMonth {
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
                for event in filteredEventsByMonth {
                    if event.day == Int(day) ?? 0
                        && event.month.number == month
                        && event.startDate.time.hour >= date.time.hour + 1
                        && event.startDate.time.hour <= date.time.hour + 2 {
                        print(month)
                        print(event.month.number)
                        dayWithEvents.events.append(event)
                    }
                }
                if !dayWithEvents.events.isEmpty {
                    days.append(dayWithEvents)
                }
            }
            
            if let nameOfMont = filteredEventsByMonth.first?.month.name,
               !days.isEmpty {
                let section = SectionForEvents(
                    month: nameOfMont,
                    days: days,
                    stringDays: stringDays.sorted(),
                    events: filteredEventsByMonth
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
