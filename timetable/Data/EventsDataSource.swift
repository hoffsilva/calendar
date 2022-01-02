//
//  EventsDataSource.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import EventKit

protocol EventsDataSource {
    func getEvents(from: Int, completion: @escaping ((Result<[EKEvent], Error>) -> Void))
    func requestAccess(completion: @escaping ((Bool) -> Void))
}
