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
        if let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                returningView.removeFromSuperview()
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
    
}
