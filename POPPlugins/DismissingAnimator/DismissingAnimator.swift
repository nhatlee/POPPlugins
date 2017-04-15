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
        let listSubview = transitionContext.containerView.subviews as NSArray
        listSubview.enumerateObjects({(view, idx,stop) in
            if let view = view as? UIView{
                if view.layer.opacity < 1{
                    dimmingView = view
//                    stop = true
                }
            }
        })
        
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
