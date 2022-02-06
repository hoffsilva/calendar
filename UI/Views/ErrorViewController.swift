//
//  ErrorViewController.swift
//  timetable
//
//  Created by Hoff Silva on 27/01/22.
//

import Combine
import Resolver
import UIKit
import Presentation

public protocol ErrorViewControllerDelegate: AnyObject {
    func didTopOnCloseButton()
    func didTopOnAllowCalendarAccessButton()
}

public class ErrorViewController: UIViewController {
    
    @Injected var errorViewModel: ErrorViewModel
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var allowCalendarAccessButton: UIButton!
    
    public weak var delegate: ErrorViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        loadData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            self.view.alpha = 1
        }
        errorViewModel.lodaData()
    }
    
    private func loadData() {
        errorViewModel
            .didLoadWithErrorMessage = { errorDescription in
                self.errorDescriptionLabel.text = errorDescription
        }
        
        errorViewModel
            .shouldShowAllowCalendarAccessButton = { isAccessNotaGranted in
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
        UIView.animate(withDuration: 1) {
            self.view.alpha = 0
        } completion: { _ in
            self.delegate?.didTopOnCloseButton()
        }
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
        UIView.animate(withDuration: 1) {
            self.view.alpha = 0
        } completion: { _ in
            self.delegate?.didTopOnAllowCalendarAccessButton()
        }
    }

}
