//
//  Extension+UIColor.swift
//  timetable
//
//  Created by Hoff Silva on 17/06/21.
//

import SwiftUI

extension UIColor {
    
    static var timetableRed: UIColor {
        UIColor(Color(red: 0.942, green: 0.153, blue: 0.153))
    }
    
    static var timetableGray: UIColor {
        UIColor(Color(red: 0.8, green: 0.8, blue: 0.8))
    }
    
    static var timetableDarkGray: UIColor {
        UIColor(Color(red: 0.565, green: 0.565, blue: 0.565))
    }
    
    static var timetableSystemBackgroundColor: UIColor {
        UIColor.init { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }
    
}
