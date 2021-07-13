//
//  GetEventsRepositoryImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

final class GetEventsRepositoryImp: GetEventsRepository {

    private let dataSource: EventsDataSource
    
    internal init(dataSource: EventsDataSource) {
        self.dataSource = dataSource
    }
    
    func getEvents(from: Int, completion: @escaping ((Result<[Event], Error>) -> Void)) {
        dataSource.getEvents(from: from, completion: completion)
    }
    
    func requestAccess(completion: @escaping ((Bool) -> Void)) {
        dataSource.requestAccess(completion: completion)
    }
    
}
