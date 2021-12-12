//
//  AppearenceToggle.swift
//  timetable
//
//  Created by Hoff Silva on 11/12/21.
//

import UIKit

final class AppearenceToggle: UIView {
    
    private lazy var backgroundView: UIView = {
        UIView()
    }()
    
    private lazy var foregroundView: UIView = {
        UIView()
    }()
    
    private var backgroundViewLeftConstraint: NSLayoutConstraint?
    private var backgroundViewRightConstraint: NSLayoutConstraint?
    
    private var foregroundViewLeftConstraint: NSLayoutConstraint?
    private var foregroundViewRightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(backgroundView)
        self.addSubview(foregroundView)
    }
    
    private func setupConstraints() {
        activateManuallyContraintOn(view: self)
        activateManuallyContraintOn(view: backgroundView)
        activateManuallyContraintOn(view: foregroundView)
        
        backgroundView.height(with: 18)
        backgroundView.width(with: 18)
        backgroundView.centerVertically()
        backgroundViewLeftConstraint = backgroundView.pinLeft()
        backgroundViewRightConstraint = backgroundView.getRightConstraint()

        foregroundView.height(with: 18)
        foregroundView.width(with: 18)
        foregroundView.centerVertically()
        foregroundViewLeftConstraint = foregroundView.getLeftConstraint()
        foregroundViewRightConstraint = foregroundView.pinRight()
    }
    
    private func activateManuallyContraintOn(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStyle() {
        self.backgroundColor = .clear
        backgroundView.backgroundColor = .timetableSystemBackgroundColor
        foregroundView.backgroundColor = .systemBackground
        setupCornerRadiusFor(view: backgroundView, radius: 9)
        setupCornerRadiusFor(view: foregroundView, radius: 9)
    }
    
    private func setupCornerRadiusFor(view: UIView, radius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
    
    func changeUserInterfaceStyleAnimated() {
        UIView.animate(withDuration: 0.5) { [self] in
            self.foregroundViewRightConstraint?.constant = self.foregroundViewRightConstraint?.constant == 0 ? -9 : 0
            self.backgroundViewLeftConstraint?.constant = self.backgroundViewLeftConstraint?.constant == 0 ? 9 : 0
            self.layoutIfNeeded()
        }
    }
}
