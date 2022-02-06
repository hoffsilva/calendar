//
//  Extensions+UIViewController.swift
//  UI
//
//  Created by Hoff Silva on 06/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    public static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: Bundle(for: T.self))
        }
        return instantiateFromNib()
    }
    
}
