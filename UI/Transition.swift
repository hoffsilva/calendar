//
//  Transition.swift
//  UI
//
//  Created by Hoff Silva on 19/03/22.
//

import UIKit

class Transition: NSObject {
    
//    private let originCornerRadius: CGFloat
//
//    private let animationContainer: UIView = {
//        UIView()
//    }()
//
//    private var animationContainerTopConstraint: NSLayoutConstraint?
//    private var animationContainerLeftConstraint: NSLayoutConstraint?
//    private var animationContainerWidthConstraint: NSLayoutConstraint?
//    private var animationContainerHeightConstraint: NSLayoutConstraint?
//
//    init(originCornerRadius: CGFloat) {
//        self.originCornerRadius = originCornerRadius
//    }
//
//    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 3
//    }
//
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
//        configureAnimationContainerInitialState(originImageViewFrame: originImageViewFrame)
//
//        configureDestinationViewInitialState(destinationView,
//                                             originFrame: originImageViewFrame,
//                                             destinationFrame: destinationViewFrame)
//
//        transitionContainer.layoutIfNeeded()
//
//        configureAnimationContainerFinalState(destinationFrame: destinationViewFrame)
//
//        UIView.animate(
//            withDuration: self.transitionDuration(using: transitionContext),
//            delay: 0.0,
//            usingSpringWithDamping: 0.7,
//            initialSpringVelocity: 0.0,
//            options: [.curveEaseOut],
//            animations: {
//                self.animationContainer.layer.cornerRadius = 0
//                transitionContainer.layoutIfNeeded()
//            }, completion: { _ in
//                transitionContext.completeTransition(true)
//            })
//    }
//
//    private func configureAnimationContainerInitialState(originImageViewFrame: CGRect) {
//        animationContainer.layer.cornerRadius = self.originCornerRadius
//        animationContainer.layer.masksToBounds = true
//
//        animationContainerTopConstraint = animationContainer.pinTop(originImageViewFrame.origin.y)
//        animationContainerLeftConstraint = animationContainer.pinLeft(originImageViewFrame.origin.x)
//        animationContainerWidthConstraint = animationContainer.constraintWidth(originImageViewFrame.width)
//        animationContainerHeightConstraint = animationContainer.constraintHeight(originImageViewFrame.height)
//    }
//
//    private func configureAnimationContainerFinalState(destinationFrame: CGRect) {
//        animationContainerTopConstraint?.constant = 0
//        animationContainerLeftConstraint?.constant = 0
//        animationContainerWidthConstraint?.constant = destinationFrame.width
//        animationContainerHeightConstraint?.constant = destinationFrame.height
//    }
//
//    private func configureDestinationViewInitialState(_ destinationView: UIView,
//                                                      originFrame: CGRect,
//                                                      destinationFrame: CGRect) {
////        let screen = destinationView.subviews[0] as? ShoppingWebViewScreen
////        screen?.imageView.image = image
////        screen?.updateHeaderHeight(constant: originFrame.height)
//
//        destinationView.prepareForConstraints()
//        destinationView.pinTop()
//        destinationView.pinLeft()
//        destinationView.pinRight()
//        destinationView.constraintHeight(destinationFrame.height)
//    }

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

extension Transition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

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
                origin = UIView()
                origin.prepareForConstraints()
//
//                // pra animacao crescer no formato do ponto de origem
                origin.frame = originCell.eventDayLabel.frame
                origin.center = CGPoint(x: originCell.eventDayLabel.center.x, y: originCell.center.y)
                origin.backgroundColor = circleColor
                origin.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                containerView.addSubview(origin)
                origin.pinEdgesToSafeArea()

                presentedView.center = originCell.eventDayLabel.center
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                origin.addSubview(presentedView)
                presentedView.pinEdgesToSafeArea()

                UIView.animate(withDuration: duration, animations: {
                    self.origin.transform = CGAffineTransform.identity
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
