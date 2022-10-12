//
//  GetEventsRepositoryImp.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit
import Domain

public final class GetEventsRepositoryImp: GetEventsRepository {

    private let dataSource: EventsDataSource
    
    public init(dataSource: EventsDataSource) {
        self.dataSource = dataSource
    }
    
    public func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void)) {
        dataSource.getEvents(from: from, completion: completion)
    }
    
    public func requestAccess(completion: @escaping ((Bool, LocalizedError?) -> Void)) {
        dataSource.requestAccess(completion: completion)
    }
    
}
