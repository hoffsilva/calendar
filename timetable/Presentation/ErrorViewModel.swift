//
//  ErrorViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Combine

final class ErrorViewModel {
    
    var errorMessage: ((String)->Void)?
    var showAllowCalendarAccessButton: ((Bool)->Void)?
    
    init(errorMessage: String, allowCalendarAccess: Bool) {
        self.errorMessage?(errorMessage)
        self.showAllowCalendarAccessButton?(allowCalendarAccess)
    }
    
}
