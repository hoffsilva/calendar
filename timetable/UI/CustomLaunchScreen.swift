//
//  CustomLaunchScreen.swift
//  timetable
//
//  Created by Hoff Silva on 04/12/21.
//

import UIKit

public protocol CustomLaunchScreenDelegate: AnyObject {
    func finishDidLoad()
}

public class CustomLaunchScreen: UIViewController {
    
    @IBOutlet weak var appIconImageView: UIImageView!
    
    public weak var delegate: CustomLaunchScreenDelegate?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppIconImage()
        waitingForLoading()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
