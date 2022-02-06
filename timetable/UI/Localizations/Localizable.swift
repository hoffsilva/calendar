//
//  Localizable.swift
//  timetable
//
//  Created by Hoff Silva on 29/01/22.
//

import Foundation

public final class Localizable {
    
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
    
    static func closeButtonTitle() -> String {
        getLocalizedString(of: "close_button_title")
    }
    
    static func allowCalendarAccessButtonTitle() -> String {
        getLocalizedString(of: "allowCalendarAccess_button_title")
    }
    
    static func descriptionOfErrorScreenWhenCalendarAccessNotGranted() -> String {
        getLocalizedString(of: "error_screen_allowCallendarAccess_description")
    }
    
    private static func getLocalizedString(of key: String) -> String {
        NSLocalizedString(key, bundle: Bundle(for: Localizable.self), comment: key)
    }
    
}
