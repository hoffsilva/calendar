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
    
    func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void)) {
        
        let date = Date()
        
        guard let numericMonth = Int(date.getShortMonth()),
              let next = Calendar(identifier: .gregorian).date(byAdding: .month, value: 12 - numericMonth, to: date) else { return }
        
        let predicate = store.predicateForEvents(withStart: date, end: next, calendars: nil)
        
        let events = store.events(matching: predicate)
        
        completion(.success(events))
    }
    
    
    
}
