//
//  CalendarManagerImpl.swift
//  Oxygene
//
//  Created by Hoff Silva on 2022-09-28.
//  Copyright © 2022 CGI. All rights reserved.
//

import EventKit
import Domain

public final class CalendarManagerImpl: CalendarManager {
    
    private lazy var store: EKEventStore = {
        EKEventStore()
    }()
    
    private let entityType = EKEntityType.event
    
    var accessGranted: (()->Void)?
    var didCreateEvent: ((String)->Void)?
    var accessDenied: (()->Void)?
    var eventAlreadyExists: (()->Void)?

    public init() {}
    
    private func getAuthorizationStatus() {
        switch EKEventStore.authorizationStatus(for: self.entityType) {
        case .authorized:
            self.accessGranted?()
        case .denied, .notDetermined, .restricted: ()
            self.accessDenied?()
        @unknown default:
            fatalError()
        }
    }
    
    func requestAccess() {
        store.requestAccess(to: self.entityType) { _,_ in
            self.getAuthorizationStatus()
        }
    }
    
    public func createEvent(_ event: Event, completion: @escaping ((Result<String, Error>) -> Void)) {
        let eventStore = EKEvent(eventStore: store)
        eventStore.title = event.title
        eventStore.startDate = event.startDate
        eventStore.endDate = event.endDate
        eventStore.notes = event.note
        eventStore.calendar = store.defaultCalendarForNewEvents
        do {
            try store.save(eventStore, span: .thisEvent, commit: true)
            completion(.success(eventStore.eventIdentifier))
        } catch let error {
            completion(.failure(error))
        }

    }
    
    
}
