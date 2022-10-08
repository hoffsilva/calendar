//
//  Transition.swift
//  UI
//
//  Created by Hoff Silva on 19/03/22.
//

import UIKit

class Transition: NSObject {
    var circle = UIView()
    
    var duration = 0.3
}

final class ShowTransition: Transition, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            
            circle = UIView()
            circle.prepareForConstraints()
            circle.frame = presentedView.frame
            
            circle.backgroundColor = .timetableSystemBackgroundColor
            containerView.addSubview(circle)
            circle.pinEdgesToSuperview()
            
            presentedView.prepareForConstraints()
            containerView.addSubview(presentedView)
            presentedView.pinEdgesToSuperview()
            
            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.alpha = 1
            }, completion: { (success:Bool) in
                transitionContext.completeTransition(success)
            })
        }
    }
}
