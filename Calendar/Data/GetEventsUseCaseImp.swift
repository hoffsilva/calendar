//
//  GetEventsUseCaseImp.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

final class GetEventsUseCaseImp: GetEventsUseCase {
    
    let repository = GetEventsRepositoryImp(dataSource: EventsDataSourceImp())
    
    func getEvents(from year: Int, completion: @escaping ((Result<[SectionForEvents], Error>) -> Void)) {
        repository.getEvents(from: year) { result in
            switch result {
            case .success(let events):
                completion(.success(self.createSections(from: events)))
            case .failure: ()
            }
        }
    }
    
    enum CalendarError: Error {
        case generic
    }
    
    private func createSections(from events: [Event]) -> [SectionForEvents] {
        var sections = [SectionForEvents]()
        for month in 1...12 {
            let filteredEvents = events.filter { event in
                event.month.number == month
            }
            let section = SectionForEvents(id: nil, month: filteredEvents.first?.month.name ?? "", events: filteredEvents)
            sections.append(section)
            print(section.month)
        }
        return sections
    }
    
}
