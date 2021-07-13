//
//  EventViewModel.swift
//  Calendar
//
//  Created by Hoff Silva on 29/05/21.
//

import Combine
import Foundation

final class EventViewModel: ObservableObject {
    
    private let eventUseCase = GetEventsUseCaseImp()
    
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
