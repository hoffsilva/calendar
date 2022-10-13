//
//  GetEventsUseCaseImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit
import Domain

public final class GetEventsUseCaseImp: GetEventsUseCase {
    
    private let getEventsRepository: GetEventsRepository
    
    public init(getEventsRepository: GetEventsRepository) {
        self.getEventsRepository = getEventsRepository
    }

    public func getEvents(from year: Int, completion: @escaping ((Result<[Month], Error>) -> Void)) {
        getEventsRepository.requestAccess { granted, error in
            if let safeError = error {
                completion(.failure(NSError.init(domain: safeError.localizedDescription, code: 0, userInfo: nil)))
            } else if granted {
                self.getEventsRepository.getEvents(from: year) { result in
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
            day: event.startDate.getIntDay(),
            acceptanceAnswer: AcceptanceAnswer(
                rawValue: event.status.rawValue) ?? .notAnswered
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
    
    private func getDays(of month: Months, and year: String) -> [Day] {
        [
            Day(number: "01", date: Date().getCurrentDate(day: "01", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "02", date: Date().getCurrentDate(day: "02", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "03", date: Date().getCurrentDate(day: "03", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "04", date: Date().getCurrentDate(day: "04", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "05", date: Date().getCurrentDate(day: "05", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "06", date: Date().getCurrentDate(day: "06", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "07", date: Date().getCurrentDate(day: "07", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "08", date: Date().getCurrentDate(day: "08", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "09", date: Date().getCurrentDate(day: "09", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "10", date: Date().getCurrentDate(day: "10", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "11", date: Date().getCurrentDate(day: "11", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "12", date: Date().getCurrentDate(day: "12", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "13", date: Date().getCurrentDate(day: "13", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "14", date: Date().getCurrentDate(day: "14", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "15", date: Date().getCurrentDate(day: "15", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "16", date: Date().getCurrentDate(day: "16", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "17", date: Date().getCurrentDate(day: "17", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "18", date: Date().getCurrentDate(day: "18", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "19", date: Date().getCurrentDate(day: "19", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "20", date: Date().getCurrentDate(day: "20", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "21", date: Date().getCurrentDate(day: "21", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "22", date: Date().getCurrentDate(day: "22", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "23", date: Date().getCurrentDate(day: "23", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "24", date: Date().getCurrentDate(day: "24", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "25", date: Date().getCurrentDate(day: "25", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "26", date: Date().getCurrentDate(day: "26", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "27", date: Date().getCurrentDate(day: "27", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "28", date: Date().getCurrentDate(day: "28", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "29", date: Date().getCurrentDate(day: "29", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "30", date: Date().getCurrentDate(day: "30", month: month.rawValue, year: year), events: [Event](), hours: getHours()),
            Day(number: "31", date: Date().getCurrentDate(day: "31", month: month.rawValue, year: year), events: [Event](), hours: getHours())
        ]
    }
    
    private func getHours() -> [Hour] {
        var hours = [Hour]()
        let isoDate = "00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let date = dateFormatter.date(from:isoDate)!
        for time in 0...23 {
            let name = Calendar.current.date(
                byAdding: .hour,
                value: time,
                to: date)?.getShortHour()
            hours.append(Hour(name: name ?? "", events: []))
        }
        return hours
    }
    
    private func mapEvent(events: [EKEvent]) -> [Month] {
        
        var jan = Month(name: "", days: getDays(of: .jan, and: "\(Date().getYear())"), month: .jan)
        var fev = Month(name: "", days: getDays(of: .fev, and: "\(Date().getYear())"), month: .fev)
        var mar = Month(name: "", days: getDays(of: .mar, and: "\(Date().getYear())"), month: .mar)
        var apr = Month(name: "", days: getDays(of: .apr, and: "\(Date().getYear())"), month: .apr)
        var may = Month(name: "", days: getDays(of: .may, and: "\(Date().getYear())"), month: .may)
        var jun = Month(name: "", days: getDays(of: .jun, and: "\(Date().getYear())"), month: .jun)
        var jul = Month(name: "", days: getDays(of: .jul, and: "\(Date().getYear())"), month: .jul)
        var aug = Month(name: "", days: getDays(of: .aug, and: "\(Date().getYear())"), month: .aug)
        var sep = Month(name: "", days: getDays(of: .sep, and: "\(Date().getYear())"), month: .sep)
        var oct = Month(name: "", days: getDays(of: .oct, and: "\(Date().getYear())"), month: .oct)
        var nov = Month(name: "", days: getDays(of: .nov, and: "\(Date().getYear())"), month: .nov)
        var dec = Month(name: "", days: getDays(of: .dec, and: "\(Date().getYear())"), month: .dec)
        
        
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
