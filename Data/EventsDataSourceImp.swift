//
//  EventsDataSourceImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit
import Domain

final class EventsDataSourceImp: EventsDataSource {
    
    private lazy var store: EKEventStore = {
        EKEventStore()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    func requestAccess(completion: @escaping ((Bool, LocalizedError?) -> Void)) {
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                completion(granted, nil)
            } else {
                completion(false, EventsDataSourceImpError.notGranted)
            }
        }
    }
    
    func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void)) {
        let today = Date()
        guard let numericMonth = Int(today.getShortMonth()),
              let endDate = Calendar(identifier: .gregorian).date(byAdding: .month, value: 12 - numericMonth, to: today) else { return }
        let predicate = store.predicateForEvents(withStart: today, end: endDate, calendars: nil)
        let events = store.events(matching: predicate)
        completion(.success(events))
    }
}

enum EventsDataSourceImpError: LocalizedError {
    case notGranted
    
    var errorDescription: String? {
        switch self {
        case .notGranted:
            return ""
        }
    }
}
