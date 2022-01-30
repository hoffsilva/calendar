//
//  ErrorViewController.swift
//  timetable
//
//  Created by Hoff Silva on 27/01/22.
//

import Combine
import Resolver
import UIKit

protocol ErrorViewControllerDelegate: AnyObject {
    func didTopOnCloseButton()
    func didTopOnAllowCalendarAccessButton()
}

class ErrorViewController: UIViewController {
    
    @Injected var errorViewModel: ErrorViewModel
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var allowCalendarAccessButton: UIButton!
    
    weak var delegate: ErrorViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 3) {
            self.view.alpha = 1
        }
        loadData()
    }
    
    private func loadData() {
        errorViewModel
            .errorMessage = { errorDescription in
                self.errorDescriptionLabel.text = errorDescription
        }
        
        errorViewModel
            .showAllowCalendarAccessButton = { isAccessNotaGranted in
                self.allowCalendarAccessButton.isHidden = isAccessNotaGranted
            }
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupCloseButton()
        setupAllowCalendarAccessButton()
    }
    
    private func setupLabelFont() {
        errorTitleLabel.font = .rubikBold(80)
        errorDescriptionLabel.font = .rubikBold(64)
    }
    
    private func setupLabelColor() {
        errorTitleLabel.textColor = .timetableRed
        errorDescriptionLabel.textColor = .timetableSystemBackgroundColor
    }
    
    private func setupCloseButton() {
        let font = UIFont.rubikBold(16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.timetableRed,
        ]
        let buttonTitle = NSAttributedString(string: Localizable.closeButtonTitle(), attributes: attributes)
        closeButton.setAttributedTitle(buttonTitle, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnCloseButton() {
        self.delegate?.didTopOnCloseButton()
    }
    
    private func setupAllowCalendarAccessButton() {
        let font = UIFont.rubikBold(16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.timetableRed,
        ]
        let buttonTitle = NSAttributedString(string: Localizable.allowCalendarAccessButtonTitle(), attributes: attributes)
        allowCalendarAccessButton.setAttributedTitle(buttonTitle, for: .normal)
        allowCalendarAccessButton.addTarget(self, action: #selector(didTapOnAllowCalendarAccessButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnAllowCalendarAccessButton() {
        self.delegate?.didTopOnAllowCalendarAccessButton()
    }

}
