//
//  EventsDataSourceImp.swift
//  Calendar
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
    
    private var isAccessGranted = false
    
    init() {
        requestAccess()
    }
    
    private func requestAccess() {
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                self.isAccessGranted = granted
            } else {
                self.isAccessGranted = false
            }
        }
    }
    
    func getEvents(from: Int, completion: @escaping ((Result<[Event], Error>) -> Void)) {
        
        if !isAccessGranted {
            requestAccess()
        }
        
        guard
            let startDate = dateFormatter.date(from: "01/01/\(from)"),
            let endDate = dateFormatter.date(from: "31/12/\(from)")
        else { return completion(.failure(NSError(domain: "", code: 0, userInfo: nil))) }
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let events = store.events(matching: predicate)
        
        completion(.success(mapEvent(events: events)))
    }
    
    private func mapEvent(events: [EKEvent]) -> [Event] {
        events.map { event in
            Event(
                startDate: event.startDate,
                endDate: event.endDate,
                isAllDay: event.isAllDay,
                location: Location(
                    latitude: event.structuredLocation?.geoLocation?.coordinate.latitude ?? 0,
                    longitude: event.structuredLocation?.geoLocation?.coordinate.longitude ?? 0
                ),
                month: getMonth(of: event.startDate),
                title: event.title
            )
        }
    }
    
    private func getMonth(of date: Date) -> Month {
        let dateComponent = Calendar.current.dateComponents([.month], from: date)
        self.dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
        guard let monthNumber = dateComponent.month else {
            return Month(name: "0", number: 0)
        }
        return Month(
            name: dateFormatter.string(from: date),
            number: monthNumber
        )
    }
    
}
