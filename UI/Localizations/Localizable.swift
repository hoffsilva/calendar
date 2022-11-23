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
    
    static func backButtonTitle() -> String {
        getLocalizedString(of: "back_button_title")
    }
    
    static func addEventButtonTitle() -> String {
        getLocalizedString(of: "add_event_button_title")
    }
    
    static func eventTitleTextFieldPlaceHolder() -> String {
        getLocalizedString(of: "event_title_textfield_placeholder")
    }
    
    static func cancelButtonTitle() -> String {
        getLocalizedString(of: "cancel_button")
    }
    
    static func saveButtonTitle() -> String {
        getLocalizedString(of: "save_button")
    }
    
    static func allDayLabelTitle() -> String {
        getLocalizedString(of: "all_day")
    }
    
    static func addLocationButtonTitle() -> String {
        getLocalizedString(of: "add_location")
    }
    
    static func addNoteButtonTitle() -> String {
        getLocalizedString(of: "add_note")
    }
    
    static func addAlertButtonTitle() -> String {
        getLocalizedString(of: "add_alert")
    }
    
    static func sundayTitle() -> String {
        getLocalizedString(of: "sunday")
    }
    
    static func mondayTitle() -> String {
        getLocalizedString(of: "monday")
    }
    
    static func tuesdayTitle() -> String {
        getLocalizedString(of: "tuesday")
    }
    
    static func wednsdayTitle() -> String {
        getLocalizedString(of: "wednsday")
    }
    
    static func thursdayTitle() -> String {
        getLocalizedString(of: "thursday")
    }
    
    static func fridayTitle() -> String {
        getLocalizedString(of: "friday")
    }
    
    static func saturdayTitle() -> String {
        getLocalizedString(of: "saturday")
    }
    
    private static func getLocalizedString(of key: String) -> String {
        NSLocalizedString(key, bundle: Bundle(for: Localizable.self), comment: key)
    }
    
}
