//
//  EventViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/05/21.
//

import Foundation
import Resolver
import Domain

final class EventViewModel: ObservableObject {
    
    @Injected private var eventUseCase: GetEventsUseCase
    
    var sections: (([Month])->Void)?
    var didGetErrorMessage: ((String)->Void)?
    
    
    func requestAccess() {
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
