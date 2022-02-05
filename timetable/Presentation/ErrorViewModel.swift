//
//  ErrorViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Combine

final class ErrorViewModel {
    
    var didLoadWithErrorMessage: ((String)->Void)?
    var shouldShowAllowCalendarAccessButton: ((Bool)->Void)?
    
    private let errorMessage: String
    private let showAllowCalendarAccessButton: Bool
    
    init(errorMessage: String, allowCalendarAccess: Bool) {
        self.errorMessage = errorMessage
        self.showAllowCalendarAccessButton = allowCalendarAccess
    }
    
    func lodaData() {
        self.didLoadWithErrorMessage?(errorMessage)
        self.shouldShowAllowCalendarAccessButton?(showAllowCalendarAccessButton)
    }
    
}
