//
//  CustomLaunchScreen.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import UIKit

class CustomLaunchScreen: UIViewController {
    
    
    @IBOutlet weak var appIconImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppIconImage()
    }
    
    private func setAppIconImage() {
        appIconImageView.image = traitCollection
            .userInterfaceStyle == .light ? UIImage(named: "LaunchScreenIconWhite") : UIImage(named: "LaunchScreenIconBlack")
    }
            
    
            

}
