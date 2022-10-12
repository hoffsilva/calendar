//
//  AddEventRepository.swift
//  Data
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//

import Domain

public protocol AddEventRepository {
    func addEvent(_ event: Event, completion: @escaping ((Result<String, Error>) -> Void))
}
