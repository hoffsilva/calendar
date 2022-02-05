//
//  GetEventsRepositoryImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit
import Domain

final class GetEventsRepositoryImp: GetEventsRepository {

    private let dataSource: EventsDataSource
    
    internal init(dataSource: EventsDataSource) {
        self.dataSource = dataSource
    }
    
    func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void)) {
        dataSource.getEvents(from: from, completion: completion)
    }
    
    func requestAccess(completion: @escaping ((Bool, LocalizedError?) -> Void)) {
        dataSource.requestAccess(completion: completion)
    }
    
}
