//
//  EventViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/05/21.
//

import Combine
import Foundation
import Resolver

final class EventViewModel: ObservableObject {
    
    @Injected private var eventUseCase: GetEventsUseCase
    
    init(eventUseCase: GetEventsUseCase) {
        self.eventUseCase = eventUseCase
    }
    
    @Published var sections: [SectionForEvents] = []
    
    func requestAccess() {
        eventUseCase.getEvents(from: 2021) { result in
            switch result {
            case .success(let sections):
                DispatchQueue.main.async {
                    self.sections = sections
                }
            case .failure: ()
            }
        }
    }
    
}
