//
//  AlerTransitioningController.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

class AlertTransitioningController: NSObject {
    private weak var transitionContext: UIViewControllerContextTransitioning?
    
    private var isPresenting: Bool = false
}

extension AlertTransitioningController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension AlertTransitioningController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let animationDuration = transitionDuration(using: transitionContext)
        isPresenting = toVC is AlertController
        
        guard let vc = (isPresenting ? toVC : fromVC) else {
            transitionContext.completeTransition(false)
            return
        }
        
        if isPresenting {
            transitionContext.containerView.addSubview(vc.view)
            transitionContext.containerView.bringSubviewToFront(vc.view)
            vc.view.frame = transitionContext.containerView.frame
            vc.view.transform = .init(scaleX: 1.15, y: 1.15)
            vc.view.alpha = 0
        }
        
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            guard let self = self else {
                return
            }
            if self.isPresenting {
                vc.view.transform = .identity
                vc.view.alpha = 1
            } else {
                vc.view.alpha = 0
            }
        }, completion: { [weak self] finished in
            self?.transitionContext?.completeTransition(finished)
        })
    }
}

extension AlertTransitioningController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if !isPresenting {
            transitionContext?.containerView.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
        transitionContext?.completeTransition(flag)
    }
}
