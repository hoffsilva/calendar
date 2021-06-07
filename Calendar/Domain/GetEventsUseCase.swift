//
//  GetEventsUseCase.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//

protocol GetEventsUseCase {
    func getEvents(from year: Int, completion: @escaping((Result<[SectionForEvents], Error>) -> Void))
}
