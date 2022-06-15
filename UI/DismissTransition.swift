//
//  DismissTransition.swift
//  UI
//
//  Created by Hoff Silva on 2022-06-15.
//

import UIKit

final class DismissTransition: Transition, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            let viewCenter = returningView.center
            
            UIView.animate(withDuration: duration, animations: {
                
                containerView.insertSubview(returningView, belowSubview: returningView)
                containerView.insertSubview(self.circle, belowSubview: returningView)
                
                
            }, completion: { (success:Bool) in
                returningView.center = viewCenter
                returningView.removeFromSuperview()
                
                self.circle.removeFromSuperview()
                
                transitionContext.completeTransition(success)
                
            })
            
        }
    }
    
}
