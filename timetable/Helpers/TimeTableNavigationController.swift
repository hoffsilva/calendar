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
    
    private lazy var appearenceToggle: AppearenceToggle = {
        AppearenceToggle()
    }()
    
    private lazy var userInterfaceStyleNameLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(12)
        label.addCharacterSpacing(kernValue: 50)
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearenceToggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearenceToggleTitle()
    }
    
    private func configureAppearenceToggle() {
        setupViewsHierarchy()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateUserInterfaceStyle))
        appearenceToggle.addGestureRecognizer(tap)
    }
    
    private func setAppearenceToggleTitle() {
        self.overrideUserInterfaceStyle = .dark
        userInterfaceStyleNameLabel.text = self.overrideUserInterfaceStyle == .dark ? "LIGHT MODE" : "DARK MODE"
        userInterfaceStyleNameLabel.textColor = self.overrideUserInterfaceStyle == .dark ? .white : .black
    }
    
    
    @objc private func animateUserInterfaceStyle() {
        UIView.animate(withDuration: 0.2) {
            self.overrideUserInterfaceStyle = self.overrideUserInterfaceStyle == .dark ? .light : .dark
            self.view.layoutIfNeeded()
        }
        appearenceToggle.changeUserInterfaceStyleAnimated()
        setAppearenceToggleTitle()
    }
    
    private func setupViewsHierarchy() {
        self.navigationBar.addSubview(appearenceToggle)
        self.navigationBar.addSubview(userInterfaceStyleNameLabel)
    }
    
    private func setupConstraints() {
        appearenceToggle.height(with: 18)
        appearenceToggle.width(with: 27)
        appearenceToggle.centerVertically(inRelationTo: self.navigationBar)
        appearenceToggle.pinLeft(24)
        
        userInterfaceStyleNameLabel.centerVertically(inRelationTo: appearenceToggle)
        userInterfaceStyleNameLabel.pinLeftInRelation(to: appearenceToggle.rightAnchor, 8)

    }
    
}
