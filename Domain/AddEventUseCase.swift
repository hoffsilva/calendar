//
//  AddEventUseCase.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//

import Foundation

public protocol AddEventUseCase {
    func addEvent(_ event: Event, completion: @escaping((Result<String, Error>) -> Void))
}

