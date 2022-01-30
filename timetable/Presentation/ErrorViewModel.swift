//
//  ErrorViewModel.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Combine

final class ErrorViewModel {
    
    @Published var errorMessage: String
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
}
