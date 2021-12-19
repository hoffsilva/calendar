//
//  GetEventsUseCase.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

import Foundation

protocol GetEventsUseCase {
    func getEvents(from year: Int, completion: @escaping((Result<[Month], Error>) -> Void))
}
