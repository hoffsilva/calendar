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
        
       let date = Date()
        guard let next = Calendar(identifier: .gregorian).date(byAdding: .year, value: 1, to: date) else { return }
        
        let predicate = store.predicateForEvents(withStart: date, end: next, calendars: nil)
        let events = store.events(matching: predicate)
        
        completion(.success(mapEvent(events: events)))
    }
    
    private func populateInfoOf(month: inout Month, with event: EKEvent) {
        month.name = event.startDate.getLongMonth()
        let newEvent = Event(
            startDate: event.startDate,
            endDate: event.endDate,
            isAllDay: event.isAllDay,
            location: event.location,
            title: event.title,
            year: event.startDate.getYear(),
            day: event.startDate.getIntDay()
        )
        month.events.append(newEvent)
    }
    
    private func mapEvent(events: [EKEvent]) -> [Month] {
        
        var jan = Month(name: "", events: [Event](), month: .jan)
        var fev = Month(name: "", events: [Event](), month: .fev)
        var mar = Month(name: "", events: [Event](), month: .mar)
        var apr = Month(name: "", events: [Event](), month: .apr)
        var may = Month(name: "", events: [Event](), month: .may)
        var jun = Month(name: "", events: [Event](), month: .jun)
        var jul = Month(name: "", events: [Event](), month: .jul)
        var aug = Month(name: "", events: [Event](), month: .aug)
        var sep = Month(name: "", events: [Event](), month: .sep)
        var oct = Month(name: "", events: [Event](), month: .oct)
        var nov = Month(name: "", events: [Event](), month: .nov)
        var dec = Month(name: "", events: [Event](), month: .dec)
        
        
        
        for event in events {
            switch event.startDate.getShortMonth() {
            case Months.jan.rawValue:
                populateInfoOf(month: &jan, with: event)
            case Months.fev.rawValue:
                populateInfoOf(month: &fev, with: event)
            case Months.mar.rawValue:
                populateInfoOf(month: &mar, with: event)
            case Months.apr.rawValue:
                populateInfoOf(month: &apr, with: event)
            case Months.may.rawValue:
                populateInfoOf(month: &may, with: event)
            case Months.jun.rawValue:
                populateInfoOf(month: &jun, with: event)
            case Months.jul.rawValue:
                populateInfoOf(month: &jul, with: event)
            case Months.aug.rawValue:
                populateInfoOf(month: &aug, with: event)
            case Months.sep.rawValue:
                populateInfoOf(month: &sep, with: event)
            case Months.oct.rawValue:
                populateInfoOf(month: &oct, with: event)
            case Months.nov.rawValue:
                populateInfoOf(month: &nov, with: event)
            case Months.dec.rawValue:
                populateInfoOf(month: &dec, with: event)
            default:
                ()
            }
        }
        let months = [jan, fev, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
        return months.filter { !$0.name.isEmpty }
    }
    
}
