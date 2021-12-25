//
//  TimeTableNavigationController.swift
//  timetable
//
//  Created by Hoff Silva on 25/12/21.
//

import UIKit

final class TimeTableNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
