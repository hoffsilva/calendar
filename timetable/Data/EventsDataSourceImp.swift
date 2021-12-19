//
//  EventsDataSourceImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit

final class EventsDataSourceImp: EventsDataSource {
    
    private lazy var store: EKEventStore = {
        EKEventStore()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    func requestAccess(completion: @escaping ((Bool) -> Void)) {
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                completion(granted)
            } else {
                completion(false)
            }
        }
    }
    
    func getEvents(from: Int, completion: @escaping ((Result<[Month], Error>) -> Void)) {
        
        guard
            let startDate = dateFormatter.date(from: "01/01/\(from)"),
            let endDate = dateFormatter.date(from: "31/12/\(from)")
        else { return completion(.failure(NSError(domain: "", code: 0, userInfo: nil))) }
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let events = store.events(matching: predicate)
        
        completion(.success(mapEvent(events: events)))
    }
    
    private func mapEvent(events: [EKEvent]) -> [Month] {
        
        for event in events {
            switch event.startDate.getMonth() {
            case Months.jan.rawValue:
                print()
            default:
                print()
            }
        }
        
//        events.map { event in
//            Event(
//                startDate: event.startDate,
//                endDate: event.endDate,
//                isAllDay: event.isAllDay,
//                location: Location(
//                    latitude: event.structuredLocation?.geoLocation?.coordinate.latitude ?? 0,
//                    longitude: event.structuredLocation?.geoLocation?.coordinate.longitude ?? 0
//                ),
//                title: event.title,
//                year: event.startDate.getYear(),
//                day: event.startDate.getIntDay()
//            )
//        }
       return [Month]()
    }
    
}
