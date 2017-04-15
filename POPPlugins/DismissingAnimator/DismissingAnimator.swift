//
//  DismissingAnimator.swift
//  Swoppler
//
//  Created by nhatlee on 4/14/17.
//  Copyright © 2017 Le Tien Nhat. All rights reserved.
//

import UIKit
import pop

class DismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else{ return }
        toVC.view.tintAdjustmentMode = .normal
        toVC.view.isUserInteractionEnabled = true
        
        
        
        var dimmingView: UIView?
        for (index, view) in transitionContext.containerView.subviews.enumerated(){
            if view.layer.opacity < 1{
                dimmingView = view
            }
        }
        
        let opacityAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        opacityAnimation?.toValue = 0
        
        let offScreenAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY)
        let yPostion = fromVC.view.layer.position.y
        offScreenAnimation?.toValue = -yPostion
        offScreenAnimation?.completionBlock = { animation, isFinished in
            transitionContext.completeTransition(true)
        }
        
        fromVC.view.layer.pop_add(offScreenAnimation, forKey: "offscreenAnimation")
        dimmingView?.layer.pop_add(opacityAnimation, forKey: "opacityAnimation")
        
        
        
        
        
        
        
        
        
        
        
    }
}
