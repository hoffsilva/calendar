//
//  ErrorViewController.swift
//  timetable
//
//  Created by Hoff Silva on 27/01/22.
//

import Combine
import Resolver
import UIKit

class ErrorViewController: UIViewController {
    
    @Injected var errorViewModel: ErrorViewModel
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
    
    private func loadData() {
        errorViewModel.$errorMessage.sink { <#String#> in
            <#code#>
        }.store(in: &bag)
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupButton()
    }
    
    private func setupLabelFont() {
        errorTitleLabel.font = .rubikBold(80)
        errorDescriptionLabel.font = .rubikBold(64)
    }
    
    private func setupLabelColor() {
        errorTitleLabel.textColor = .timetableRed
        errorDescriptionLabel.textColor = .timetableSystemBackgroundColor
    }
    
    private func setupButton() {
        closeButton.setTitle(Localizable.closeAction(), for: .normal)
        closeButton.setTitleColor(.timetableRed, for: .normal)
    }

}
