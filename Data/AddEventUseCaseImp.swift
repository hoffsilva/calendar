//
//  AddEventUseCaseImp.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//

import Domain

public final class AddEventUseCaseImp: AddEventUseCase {
    
    private let addEventRepository: AddEventRepository
    
    public init(addEventRepository: AddEventRepository) {
        self.addEventRepository = addEventRepository
    }
    
    public func addEvent(_ event: Event, completion: @escaping ((Result<String, Error>) -> Void)) {
        addEventRepository.addEvent(event, completion: completion)
    }
    
    
}
