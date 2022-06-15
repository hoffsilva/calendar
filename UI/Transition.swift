//
//  Transition.swift
//  UI
//
//  Created by Hoff Silva on 19/03/22.
//

import UIKit

class Transition: NSObject {
    
    private let originView: UIView

    init(originView: UIView) {
        self.originView = originView
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3
    }

//    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let originNavigationViewController = transitionContext.viewController(forKey: .from) as? TimeTableNavigationController,
//              let originViewController = originNavigationViewController.viewControllers.first as? EventListViewController,
//              let destinationViewController = transitionContext.viewController(forKey: .to),
//              let destinationView = transitionContext.view(forKey: .to),
//              let originImageViewFrame = originViewController.cell?.superview?
//            .convert(originViewController.cell!.frame,
//                         to: nil)
//        else { return }
//
//        let transitionContainer = transitionContext.containerView
//        let destinationViewFrame = transitionContext.finalFrame(for: destinationViewController)
//
//        animationContainer.addSubview(destinationView)
//        transitionContainer.addSubview(animationContainer)
//
////        configureAnimationContainerInitialState(originImageViewFrame: originImageViewFrame)
//
////        configureDestinationViewInitialState(destinationView,
////                                             originFrame: originImageViewFrame,
////                                             destinationFrame: destinationViewFrame)
//
//        transitionContainer.layoutIfNeeded()
//
////        configureAnimationContainerFinalState(destinationFrame: destinationViewFrame)
//
//        UIView.animate(
//            withDuration: self.transitionDuration(using: transitionContext),
//            delay: 0.0,
//            usingSpringWithDamping: 0.7,
//            initialSpringVelocity: 0.0,
//            options: [.curveEaseOut],
//            animations: {
//                self.animationContainer.layer.cornerRadius = 0
////                transitionContainer.layoutIfNeeded()
//            }, completion: { _ in
//                transitionContext.completeTransition(true)
//            })
//    }

//

//    var origin = UIView()
//
//    var startingPoint = CGPoint.zero {
//        didSet {
//            origin.center = startingPoint
//        }
//    }
//

//
    enum TransitionMode:Int {
        case present, dismiss, pop
    }

    var transitionMode: TransitionMode = .present
    
}

extension Transition: UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if transitionMode == .present {

            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to),
                let originNavigationViewController = transitionContext.viewController(forKey: .from) as? TimeTableNavigationController,
               let originViewController = originNavigationViewController.viewControllers.first as? EventListViewController,
               let originCell = originViewController.cell {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame

                presentedView.prepareForConstraints()
                // pra animacao nascer do formato do ponto de origem

                originView.prepareForConstraints()
//
//                // pra animacao crescer no formato do ponto de origem
                originView.frame = originCell.eventDayLabel.frame
//                ori.center = CGPoint(x: originCell.eventDayLabel.center.x, y: originCell.center.y)
                originView.backgroundColor = .timetableSystemBackgroundColor
                originView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(originView)
                originView.pinEdgesToSafeArea()

//                presentedView.center = originCell.eventDayLabel.center
//                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                originView.addSubview(presentedView)
                presentedView.pinEdgesToSafeArea()

                UIView.animate(withDuration: 3, animations: {
                    self.originView.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
//                    presentedView.center = viewCenter

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

                UIView.animate(withDuration: 3, animations: {
                    self.originView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
//                    returningView.center = self.startingPoint
                    returningView.alpha = 0

                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.originView, belowSubview: returningView)
                    }


                    }, completion: { (success:Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()

                        self.originView.removeFromSuperview()

                        transitionContext.completeTransition(success)

                })

            }


        }

    }

}
