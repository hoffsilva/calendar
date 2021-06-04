//
//  EventViewModel.swift
//  Calendar
//
//  Created by Hoff Silva on 29/05/21.
//

import Combine

final class EventViewModel {
    
    private let eventUseCase = GetEventsUseCaseImp()
    
    @Published var events: [Event] = []
    
    func requestAccess() {
        eventUseCase.getEvents(from: 2021) { result in
            switch result {
            case .success(let events):
                self.events = events
            case .failure: ()
            }
        }
    }
    
}
