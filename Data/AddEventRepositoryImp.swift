//
//  AddEventRepositoryImp.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//

import Domain

public final class AddEventRepositoryImp: AddEventRepository {
    
    private let calendarManager: CalendarManager
    
    public init(calendarManager: CalendarManager) {
        self.calendarManager = calendarManager
    }
    
    public func addEvent(_ event: Event, completion: @escaping ((Result<String, Error>) -> Void)) {
        calendarManager.createEvent(event, completion: completion)
    }
    
}
