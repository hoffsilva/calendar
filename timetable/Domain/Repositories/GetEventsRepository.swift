//
//  GetEventsRepository.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

protocol GetEventsRepository {
    func getEvents(from: Int, completion: @escaping ((Result<[Month], Error>) -> Void))
    func requestAccess(completion: @escaping ((Bool) -> Void))
}
