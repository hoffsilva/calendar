//
//  AddEventViewModel.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//


import Foundation
import Domain

public final class AddEventViewModel: ObservableObject {
    
    private var addEventUseCase: AddEventUseCase
    
    public var didGetErrorMessage: ((String)->Void)?
    public var months: [Month]?
    
    public init(
        addEventUseCase: AddEventUseCase
    ) {
            self.addEventUseCase = addEventUseCase
        }
    
    public func requestAccess(_ event: Event) {
        addEventUseCase.addEvent(event, completion: { result in
            switch result {
            case .success(let eventIdentifier):
                print(eventIdentifier) //TODO: 
            case .failure(let error):
                self.didGetErrorMessage?(error.localizedDescription)
            }
        })
    }
    
}

