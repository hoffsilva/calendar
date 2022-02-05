//
//  CustomLaunchScreen.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import UIKit

protocol CustomLaunchScreenDelegate: AnyObject {
    func finishDidLoad()
}

class CustomLaunchScreen: UIViewController {
    
    @IBOutlet weak var appIconImageView: UIImageView!
    
    weak var delegate: CustomLaunchScreenDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppIconImage()
        waitingForLoading()
    }
    
    private func setAppIconImage() {
        appIconImageView.image = traitCollection
            .userInterfaceStyle == .light ? UIImage(named: "LaunchScreenIconWhite") : UIImage(named: "LaunchScreenIconBlack")
    }
    
    private func waitingForLoading() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
            self?.delegate?.finishDidLoad()
        }
    }
            
    
            

}
