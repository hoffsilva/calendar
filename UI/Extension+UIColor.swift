//
//  Extension+UIColor.swift
//  timetable
//
//  Created by Hoff Silva on 17/06/21.
//

import SwiftUI

extension UIColor {
    
    static var timetableRed: UIColor {
        UIColor(named: "red") ?? .magenta
    }
    
    static var timetableText: UIColor {
        UIColor(named: "text") ?? .magenta
    }
    
    static var timetableGray: UIColor {
        UIColor(named: "gray") ?? .magenta
    }
    
    static var timetableDarkGray: UIColor {
        UIColor(named: "dark-gray") ?? .magenta
    }
    
    static var timetableSystemBackgroundColor: UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(named: "light-background-color") ?? .magenta
            } else {
                /// Return the color for Light Mode
                return UIColor(named: "dark-background-color") ?? .magenta
            }
        }
    }
    
}
