//
//  GetEventsRepository.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit

public protocol GetEventsRepository {
    func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void))
    func requestAccess(completion: @escaping ((Bool, LocalizedError?) -> Void))
}
