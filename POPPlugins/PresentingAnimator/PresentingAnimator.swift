//
//  PresentingAnimator.swift
//  Swoppler
//
//  Created by nhatlee on 4/14/17.
//  Copyright © 2017 Le Tien Nhat. All rights reserved.
//

import UIKit
import pop

class PresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view, let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view else{ return }
        fromView.tintAdjustmentMode = .dimmed
        fromView.isUserInteractionEnabled = false
        
        let dimmingView = UIView(frame: fromView.bounds)
        dimmingView.backgroundColor = UIColor(rgbColorCodeRed: 84, green: 84, blue: 84, alpha: 1)
        dimmingView.layer.opacity = 0
        
        toView.frame = CGRect(x: 0, y: 0, width: transitionContext.containerView.bounds.width - 60, height: transitionContext.containerView.bounds.height - 100)
        toView.center = CGPoint(x: transitionContext.containerView.center.x, y: transitionContext.containerView.center.y)
        
        transitionContext.containerView.addSubview(dimmingView)
        transitionContext.containerView.addSubview(toView)
        
        let positionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        positionAnimation?.toValue = transitionContext.containerView.center.y
        positionAnimation?.springBounciness = 10
        positionAnimation?.completionBlock = { animation, isFinished in
            transitionContext.completeTransition(true)
        }
        
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.springBounciness = 20
        scaleAnimation?.fromValue = NSValue(cgPoint: CGPoint(x: 1.2, y: 1.4))
        
        let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnimation?.toValue = 0.2
        
        toView.layer.pop_add(positionAnimation, forKey: "positionAnimation")
        toView.layer.pop_add(scaleAnimation, forKey: "scaleAnimation")
        dimmingView.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
    }
}
