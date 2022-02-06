//
//  GetEventsUseCaseImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit
import Domain

public final class GetEventsUseCaseImp: GetEventsUseCase {
    
    let repository = GetEventsRepositoryImp(dataSource: EventsDataSourceImp())
    
    public init() {}

    public func getEvents(from year: Int, completion: @escaping ((Result<[Month], Error>) -> Void)) {
        repository.requestAccess { granted, error in
            if let safeError = error {
                completion(.failure(NSError.init(domain: safeError.localizedDescription, code: 0, userInfo: nil)))
            } else if granted {
                self.repository.getEvents(from: year) { result in
                    switch result {
                    case .success(let events):
                        completion(.success(self.mapEvent(events: events)))
                    case .failure: ()
                    }
                }
            }
        }
    }
    
    private func addEventInDay(month: inout Month, with event: EKEvent) {
        
        let newEvent = Event(
            startDate: event.startDate,
            endDate: event.endDate,
            isAllDay: event.isAllDay,
            location: event.location,
            title: event.title,
            year: event.startDate.getYear(),
            day: event.startDate.getIntDay()
        )
        
        for (index, day) in month.days.enumerated() {
            if day.number == event.startDate.getDay() {
                month.days[index].events.append(newEvent)
            }
        }
    }
    
    private func populateInfoOf(month: inout Month, with event: EKEvent) {
    
        month.name = event.startDate.getLongMonth()
        
        switch event.startDate.getDay() {
        case "01": addEventInDay(month: &month, with: event)
        case "02": addEventInDay(month: &month, with: event)
        case "03": addEventInDay(month: &month, with: event)
        case "04": addEventInDay(month: &month, with: event)
        case "05": addEventInDay(month: &month, with: event)
        case "06": addEventInDay(month: &month, with: event)
        case "07": addEventInDay(month: &month, with: event)
        case "08": addEventInDay(month: &month, with: event)
        case "09": addEventInDay(month: &month, with: event)
        case "10": addEventInDay(month: &month, with: event)
        case "11": addEventInDay(month: &month, with: event)
        case "12": addEventInDay(month: &month, with: event)
        case "13": addEventInDay(month: &month, with: event)
        case "14": addEventInDay(month: &month, with: event)
        case "15": addEventInDay(month: &month, with: event)
        case "16": addEventInDay(month: &month, with: event)
        case "17": addEventInDay(month: &month, with: event)
        case "18": addEventInDay(month: &month, with: event)
        case "19": addEventInDay(month: &month, with: event)
        case "20": addEventInDay(month: &month, with: event)
        case "21": addEventInDay(month: &month, with: event)
        case "22": addEventInDay(month: &month, with: event)
        case "23": addEventInDay(month: &month, with: event)
        case "24": addEventInDay(month: &month, with: event)
        case "25": addEventInDay(month: &month, with: event)
        case "26": addEventInDay(month: &month, with: event)
        case "27": addEventInDay(month: &month, with: event)
        case "28": addEventInDay(month: &month, with: event)
        case "29": addEventInDay(month: &month, with: event)
        case "30": addEventInDay(month: &month, with: event)
        case "31": addEventInDay(month: &month, with: event)
        default:()
        }
        
    }
    
    private func getDays() -> [Day] {
        [
            Day(number: "01", events: [Event]()),
            Day(number: "02", events: [Event]()),
            Day(number: "03", events: [Event]()),
            Day(number: "04", events: [Event]()),
            Day(number: "05", events: [Event]()),
            Day(number: "06", events: [Event]()),
            Day(number: "07", events: [Event]()),
            Day(number: "08", events: [Event]()),
            Day(number: "09", events: [Event]()),
            Day(number: "10", events: [Event]()),
            Day(number: "11", events: [Event]()),
            Day(number: "12", events: [Event]()),
            Day(number: "13", events: [Event]()),
            Day(number: "14", events: [Event]()),
            Day(number: "15", events: [Event]()),
            Day(number: "16", events: [Event]()),
            Day(number: "17", events: [Event]()),
            Day(number: "18", events: [Event]()),
            Day(number: "19", events: [Event]()),
            Day(number: "20", events: [Event]()),
            Day(number: "21", events: [Event]()),
            Day(number: "22", events: [Event]()),
            Day(number: "23", events: [Event]()),
            Day(number: "24", events: [Event]()),
            Day(number: "25", events: [Event]()),
            Day(number: "26", events: [Event]()),
            Day(number: "27", events: [Event]()),
            Day(number: "28", events: [Event]()),
            Day(number: "29", events: [Event]()),
            Day(number: "30", events: [Event]()),
            Day(number: "31", events: [Event]())
        ]
    }
    
    private func mapEvent(events: [EKEvent]) -> [Month] {
        
        var jan = Month(name: "", days: getDays(), month: .jan)
        var fev = Month(name: "", days: getDays(), month: .fev)
        var mar = Month(name: "", days: getDays(), month: .mar)
        var apr = Month(name: "", days: getDays(), month: .apr)
        var may = Month(name: "", days: getDays(), month: .may)
        var jun = Month(name: "", days: getDays(), month: .jun)
        var jul = Month(name: "", days: getDays(), month: .jul)
        var aug = Month(name: "", days: getDays(), month: .aug)
        var sep = Month(name: "", days: getDays(), month: .sep)
        var oct = Month(name: "", days: getDays(), month: .oct)
        var nov = Month(name: "", days: getDays(), month: .nov)
        var dec = Month(name: "", days: getDays(), month: .dec)
        
        
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
        
        var months = [
            removeEmptyDaysOf(&jan),
            removeEmptyDaysOf(&fev),
            removeEmptyDaysOf(&mar),
            removeEmptyDaysOf(&apr),
            removeEmptyDaysOf(&may),
            removeEmptyDaysOf(&jun),
            removeEmptyDaysOf(&jul),
            removeEmptyDaysOf(&aug),
            removeEmptyDaysOf(&sep),
            removeEmptyDaysOf(&oct),
            removeEmptyDaysOf(&nov),
            removeEmptyDaysOf(&dec)
        ]
        
        months.removeAll(where: { $0.name.isEmpty })
        return months
    }
    
    private func removeEmptyDaysOf(_ month: inout Month) -> Month {
        month.days.removeAll(where: { $0.events.count == 0 })
        return month
    }
    
}
