//
//  CircularTransition.swift
//  CustomAnimations
//
//  Created by Midhet Sulemani on 10/5/19.
//  Copyright © 2019 DevFest. All rights reserved.
//

import UIKit

protocol CircleTransitionable {
  var triggerButton: UIButton { get }
  var mainView: UIView { get }
}

class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
    weak var context: UIViewControllerContextTransitioning?

  //make this zero for now and see if it matters when it comes time to make it interactive
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.0
  }
    
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
      let toVC = transitionContext.viewController(forKey: .to) else {
        transitionContext.completeTransition(false)
        return
    }
    
    context = transitionContext

    let containerView = transitionContext.containerView
    
    //Background View With Correct Color
    let backgroundView = UIView()
    backgroundView.frame = toVC.view.frame
    backgroundView.backgroundColor = fromVC.mainView.backgroundColor
    containerView.addSubview(backgroundView)
    
    //Growing Circular Mask
    containerView.addSubview(toVC.view)
    animate(toView: toVC.view, fromTriggerButton: fromVC.triggerButton)
  }

  func animate(toView: UIView, fromTriggerButton triggerButton: UIButton) {
    //Starting Path
    let rect = CGRect(x: triggerButton.frame.origin.x,
                      y: triggerButton.frame.origin.y,
                      width: triggerButton.frame.width,
                      height: triggerButton.frame.width)
    let circleMaskPathInitial = UIBezierPath(ovalIn: rect)
    
    //Destination Path
    let circleMaskPathFinal = UIBezierPath(ovalIn: triggerButton.frame.insetBy(dx: -UIScreen.main.bounds.height,
                                                                               dy: -UIScreen.main.bounds.height))
    
    //Actual mask layer
    let maskLayer = CAShapeLayer()
    maskLayer.path = circleMaskPathFinal.cgPath
    toView.layer.mask = maskLayer
    
    //Mask Animation
    let maskLayerAnimation = CABasicAnimation(keyPath: "path")
    maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
    maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
    maskLayerAnimation.delegate = self
    maskLayer.add(maskLayerAnimation, forKey: "path")
  }
  
  func animateToTextView(toTextView: UIView, fromTriggerButton: UIButton) {
    //Start toView offscreen a little and animate it to normal
    let originalCenter = toTextView.center
    toTextView.alpha = 0.0
    toTextView.center = fromTriggerButton.center
    toTextView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    
    UIView.animate(withDuration: 0.25, delay: 0.1, options: [.curveEaseOut], animations: {
      toTextView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      toTextView.center = originalCenter
      toTextView.alpha = 1.0
    }, completion: nil)
  }
}

extension CircularTransition: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    context?.completeTransition(true)
  }
}
