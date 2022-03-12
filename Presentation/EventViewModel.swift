//
//  EventViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/05/21.
//

import Foundation
import Domain

public final class EventViewModel: ObservableObject {
    
    private var eventUseCase: GetEventsUseCase
    
    public var sections: (([Month])->Void)?
    public var didGetErrorMessage: ((String)->Void)?
    public var months: [Month]?
    
    public init(
        eventUseCase: GetEventsUseCase,
        sections: (([Month]) -> Void)? = nil,
        didGetErrorMessage: ((String) -> Void)? = nil) {
            self.sections = sections
            self.didGetErrorMessage = didGetErrorMessage
            self.eventUseCase = eventUseCase
        }
    
    public func requestAccess() {
        eventUseCase.getEvents(from: 2021) { result in
            switch result {
            case .success(let sections):
                self.sections?(sections)
                self.months = sections
            case .failure(let error):
                self.didGetErrorMessage?(error.localizedDescription)
            }
        }
    }
    
}
