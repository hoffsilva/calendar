//
//  ErrorViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Combine

public final class ErrorViewModel {
    
    public var didLoadWithErrorMessage: ((String)->Void)?
    public var shouldShowAllowCalendarAccessButton: ((Bool)->Void)?
    
    private let errorMessage: String
    private let showAllowCalendarAccessButton: Bool
    
    public init(errorMessage: String, allowCalendarAccess: Bool) {
        self.errorMessage = errorMessage
        self.showAllowCalendarAccessButton = allowCalendarAccess
    }
    
    public func lodaData() {
        self.didLoadWithErrorMessage?(errorMessage)
        self.shouldShowAllowCalendarAccessButton?(showAllowCalendarAccessButton)
    }
    
}
