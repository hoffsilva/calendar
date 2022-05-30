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
        UIColor(named: "background-color") ?? .magenta
    }
    
}
