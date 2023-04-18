//
//  CXScaleDismissAnimation.swift
//  CXSwiftKit
//
//  Created by chenxing on 2022/8/11.
//

#if canImport(UIKit)
import UIKit

public class CXScaleDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var finalRect: CGRect
    
    @objc public override init() {
        self.finalRect = .zero
        super.init()
    }
    
    @objc public convenience init(rect: CGRect) {
        self.init()
        self.finalRect = rect
    }
    
    @objc public func updateFinalRect(_ rect: CGRect) {
        finalRect = rect
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let centerFrame = CGRect.init(x: cxScreenWidth/2, y: cxScreenHeight/2, width: 0, height: 0)
        var snapshotView: UIView?
        var scaleRatio: CGFloat = 1.0
        var finalFrame: CGRect = .zero
        snapshotView = fromVC.view.snapshotView(afterScreenUpdates: false)
        snapshotView?.layer.zPosition = 20
        scaleRatio = fromVC.view.frame.width / (finalRect != .zero ? finalRect.width : cxScreenWidth)
        CXLogger.log(level: .info, message: "scaleRatio=\(scaleRatio)")
        finalFrame = finalRect != .zero ? finalRect : centerFrame
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotView!)
        
        let duration = transitionDuration(using: transitionContext)
        
        fromVC.view.alpha = 0.0
        snapshotView?.center = fromVC.view.center
        //snapshotView?.transform = CGAffineTransform.init(scaleX: scaleRatio, y: scaleRatio)
        //UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
        //    snapshotView?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        //    snapshotView?.frame = finalFrame
        //}) { finished in
        //    transitionContext.finishInteractiveTransition()
        //    transitionContext.completeTransition(true)
        //    snapshotView?.removeFromSuperview()
        //}
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut) {
            snapshotView?.frame = finalFrame
        } completion: { finished in
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
            snapshotView?.removeFromSuperview()
        }
    }
    
}

#endif