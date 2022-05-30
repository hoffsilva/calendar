//
//  AppDelegate.swift
//  timetable
//
//  Created by Hoff Silva on 27/09/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        try! FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        
        do {
            sleep(5)
        }
        
        return true
    }
    
}

