//
//  EventsDataSource.swift
//  Calendar
//
//  Created by Hoff Silva on 03/06/21.
//


protocol EventsDataSource {
    func getEvents(from: Int, completion: @escaping ((Result<[Event], Error>) -> Void))
}
