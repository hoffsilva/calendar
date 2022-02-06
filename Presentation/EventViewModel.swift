//
//  EventViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/05/21.
//

import Foundation
import Resolver
import Domain

public final class EventViewModel: ObservableObject {
    
    @Injected private var eventUseCase: GetEventsUseCase
    
    public var sections: (([Month])->Void)?
    public var didGetErrorMessage: ((String)->Void)?
    
    public init(sections: (([Month]) -> Void)? = nil, didGetErrorMessage: ((String) -> Void)? = nil) {
        self.sections = sections
        self.didGetErrorMessage = didGetErrorMessage
    }
    
    public func requestAccess() {
        eventUseCase.getEvents(from: 2021) { result in
            switch result {
            case .success(let sections):
                self.sections?(sections)
            case .failure(let error):
                self.didGetErrorMessage?(error.localizedDescription)
            }
        }
    }
    
}
