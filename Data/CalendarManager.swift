//
//  File.swift
//  Oxygene
//
//  Created by Hoff Silva on 2022-09-27.
//  Copyright © 2022 CGI. All rights reserved.
//

import EventKit
import Domain

public protocol CalendarManager {
    func createEvent(_ event: Event, completion: @escaping ((Result<String, Error>) -> Void))
}
