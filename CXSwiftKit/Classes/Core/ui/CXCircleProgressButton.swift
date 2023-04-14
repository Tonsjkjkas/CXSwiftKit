//
//  CXCircleProgressButton.swift
//  CXSwiftKit
//
//  Created by chenxing on 2021/5/19.
//

#if canImport(UIKit)
import UIKit

public func cxDegreesToRadius(_ value: Double) -> CGFloat {
    return CGFloat(value * Double.pi / 180.0)
}

public class CXCircleProgressButton: UIButton {
    
    /// Represents the background color.
    @objc public var trackBackgroundColor: UIColor?
    /// Represents the track color.
    @objc public var trackColor: UIColor?
    /// Represents the progress color.
    @objc public var progressColor: UIColor?
    /// Represents the line widht of progress bar.
    @objc public var lineWidth: CGFloat = 0
    /// Represents the animation duration of progress bar.
    @objc public var animationDuration: TimeInterval = 0
    /// Represents the track margin from the outmost edge.
    @objc public var trackMargin: CGFloat = 0
    
    /// Represents the track layer.
    private var trackLayer: CAShapeLayer!
    /// Represents the path for the track.
    private var bezierPath: UIBezierPath!
    /// Represents the progress layer.
    private var progressLayer: CAShapeLayer!
    
    /// Represents the callback when the progress completed.
    @objc public var onFinish: (() -> Void)?
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func makeTrackLayer() -> CAShapeLayer {
        let trackLayer = CAShapeLayer()
        trackLayer.frame = bounds
        trackLayer.fillColor = trackBackgroundColor?.cgColor ?? UIColor.black.withAlphaComponent(0.1).cgColor
        trackLayer.lineWidth = lineWidth > 0 ? lineWidth : 2.0
        trackLayer.strokeColor = trackColor?.cgColor ?? UIColor.red.cgColor
        trackLayer.strokeStart = 0.0
        trackLayer.strokeEnd = 1.0
        trackLayer.path = bezierPath.cgPath
        return trackLayer
    }
    
    private func makeBezierPath() -> UIBezierPath {
        let width: CGFloat  = frame.width / 2
        let height: CGFloat = frame.height / 2
        let center = CGPoint(x: width, y: height)
        let radius = height - trackMargin
        let bezierPath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: cxDegreesToRadius(-90),
                                      endAngle: cxDegreesToRadius(270),
                                      clockwise: true)
        return bezierPath
    }
    
    private func makeProgressLayer() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth > 0 ? lineWidth : 2.0
        progressLayer.lineCap = .round
        progressLayer.strokeColor = progressColor?.cgColor ?? UIColor.lightGray.cgColor
        progressLayer.strokeStart = 0
        
        let animation = CABasicAnimation(keyPath: "cx.animation.strokeEnd")
        animation.duration = self.animationDuration
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.isRemovedOnCompletion = true
        animation.delegate = self
        progressLayer.add(animation, forKey: nil)
        progressLayer.path = bezierPath.cgPath
        return progressLayer
    }
    
}

//MARK: - Animation

extension CXCircleProgressButton {
    
    /// Start animating with the duration.
    @objc public func startAnimation(withDuration duration: Double) {
        animationDuration = duration
        if bezierPath == nil {
            bezierPath = makeBezierPath()
        }
        if trackLayer == nil {
            trackLayer = makeTrackLayer()
        }
        if progressLayer == nil {
            progressLayer = makeProgressLayer()
        }
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }
    
    /// Stop animating.
    @objc public func stopAnimation() {
        if trackLayer != nil {
            trackLayer.removeFromSuperlayer()
        }
        if progressLayer != nil {
            progressLayer.removeAllAnimations()
            progressLayer.removeFromSuperlayer()
        }
        bezierPath = nil
        trackLayer = nil
        progressLayer = nil
    }
    
    /// Return a value that whether to contain animation.
    @objc public func hasAnimation() -> Bool {
        return progressLayer != nil
    }
    
}

//MARK: - CAAnimationDelegate

extension CXCircleProgressButton: CAAnimationDelegate {
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            onFinish?()
        }
    }
    
}

#endif
