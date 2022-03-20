//
//  Transition.swift
//  UI
//
//  Created by Hoff Silva on 19/03/22.
//

import UIKit

class Transition: NSObject {

    var origin = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            origin.center = startingPoint
        }
    }
    
    var circleColor = UIColor.timetableSystemBackgroundColor
    
    var duration = 0.3
    
    enum TransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode: TransitionMode = .present
    
}

extension Transition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame
                
                // pra animacao nascer do formato do ponto de origem
//                origin = UIView()
//
//                // pra animacao crescer no formato do ponto de origem
//                origin.frame = viewSize
//                origin.center = startingPoint
//                origin.backgroundColor = circleColor
//                origin.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                containerView.addSubview(origin)
//                origin.prepareForConstraints()
//                origin.pinEdgesToSafeArea()
                
                
//                presentedView.center = startingPoint
//                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                presentedView.prepareForConstraints()
                presentedView.pinEdgesToSafeArea()
                
                UIView.animate(withDuration: duration, animations: {
//                    self.origin.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                    }, completion: { (success:Bool) in
                        transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame
                
                
//                origin.frame = viewSize
//
//                origin.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.origin.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.origin, belowSubview: returningView)
                    }
                    
                    
                    }, completion: { (success:Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()
                        
                        self.origin.removeFromSuperview()
                        
                        transitionContext.completeTransition(success)
                        
                })
                
            }
            
            
        }
        
    }
    
    
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    
    }
    
    
    
    
    
    
    
    
    
    

}
