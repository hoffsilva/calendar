//
//  CustomLaunchScreenCoordinator.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-11.
//

import UIKit
import Presentation
import Domain

protocol CustomLaunchScreenCoordinatorDelegate: AnyObject {
    func didLoadEvents()
}

public final class CustomLaunchScreenCoordinator: Coordinator {
 
    private let window: UIWindow
    private var customLaunchScreen: CustomLaunchScreen?
    
    weak var customLaunchScreenCoordinatorDelegate: CustomLaunchScreenCoordinatorDelegate?
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let customLaunchScreen = Resolver.resolve(CustomLaunchScreen.self)
        customLaunchScreen.delegate = self
        customLaunchScreen.overrideUserInterfaceStyle = window.overrideUserInterfaceStyle
        self.window.rootViewController = customLaunchScreen
    }

}

extension CustomLaunchScreenCoordinator: CustomLaunchScreenDelegate {
    
    public func finishDidLoad() {
        self.customLaunchScreenCoordinatorDelegate?.didLoadEvents()
    }
    
}
