//
//  Localizable.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Foundation

final class Localizable {
    
    static func darkMode() -> String {
        getLocalizedString(of: "dark_mode")
    }
    
    static func lightMode() -> String {
        getLocalizedString(of: "light_mode")
    }
    
    static func titleOfErrorScreen() -> String {
        getLocalizedString(of: "error_screen_title")
    }
    
    static func descriptionOfErrorScreen() -> String {
        getLocalizedString(of: "error_screen_description")
    }
    
    static func closeAction() -> String {
        getLocalizedString(of: "close")
    }
    
    private static func getLocalizedString(of key: String) -> String {
        NSLocalizedString(key, comment: key)
    }
    
}
