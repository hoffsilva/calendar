//
//  UIView+Extensions.swift
//  ebanx
//
//  Created by Rodrigo Longhi Guimarães on 24/04/18.
//  Copyright © 2018 EBANX. All rights reserved.
//

import EBANXUI

extension UIView {
    
    public func makeViewCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width/2
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func setCustomShadow(color: UIColor = .black,
                                alpha: Float = 0.5,
                                x: CGFloat = 0,
                                y: CGFloat = 2,
                                blur: CGFloat = 4,
                                spread: CGFloat = 0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = alpha
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = blur / 2.0
        if spread == 0 {
            self.layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    public func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
        
    public func addParallaxToView(view: UIView, horizontalAmount: CGFloat, verticalAmount: CGFloat) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -horizontalAmount
        horizontal.maximumRelativeValue = horizontalAmount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -verticalAmount
        vertical.maximumRelativeValue = verticalAmount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        view.addMotionEffect(group)
    }
    
    public func asUIImageViewPlaceholder() -> UIImageViewPlaceholder {
        UIImageViewPlaceholder(view: self)
    }
    
    public func addDashedBorder(strokeColor: UIColor, lineWidth: CGFloat = 1.0, lineDashPattern: [NSNumber] = [6, 8]) {
        let dashedLayer = CAShapeLayer()
        dashedLayer.strokeColor = strokeColor.cgColor
        dashedLayer.lineDashPattern = lineDashPattern
        dashedLayer.lineWidth = lineWidth
        dashedLayer.frame = self.bounds
        dashedLayer.fillColor = nil
        dashedLayer.path = UIBezierPath(roundedRect: self.bounds,
                                        cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.addSublayer(dashedLayer)
    }
}
