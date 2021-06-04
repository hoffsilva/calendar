//
//  GetEventsUseCaseImp.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

final class GetEventsUseCaseImp: GetEventsUseCase {
    
    let repository = GetEventsRepositoryImp(dataSource: EventsDataSourceImp())
    
    func getEvents(from year: Int, completion: @escaping ((Result<[Event], Error>) -> Void)) {
        repository.getEvents(from: year, completion: completion)
    }
    
    enum CalendarError: Error {
        case generic
    }
    
}
