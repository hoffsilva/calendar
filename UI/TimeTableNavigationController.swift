//
//  TimeTableNavigationController.swift
//  timetable
//
//  Created by Hoff Silva on 25/12/21.
//

import UIKit

public final class TimeTableNavigationController: UINavigationController {
    
    private let window: UIWindow
    
    public init(rootViewController: UIViewController, window: UIWindow) {
        self.window = window
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
        label.textColor = .timetableText
        return label
    }()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearenceToggle()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setAppearenceToggleTitle()
    }
    
    private func configureAppearenceToggle() {
        setupViewsHierarchy()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateUserInterfaceStyle))
        appearenceToggle.addGestureRecognizer(tap)
    }
    
    @objc private func setAppearenceToggleTitle() {
        userInterfaceStyleNameLabel.text = userInterfaceStyleNameLabel.text == Localizable.darkMode() ? Localizable.lightMode() : Localizable.darkMode()
    }
    
    private func setAppearenceToggleColor() {
        if self.window.overrideUserInterfaceStyle == .dark {
            self.window.overrideUserInterfaceStyle = .light
        } else {
            self.window.overrideUserInterfaceStyle = .dark
        }
        setAppearenceToggleTitle()
    }
    
    
    @objc private func animateUserInterfaceStyle() {
        appearenceToggle.changeUserInterfaceStyleAnimated()
        setAppearenceToggleColor()
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
