//
//  ProgressHUD.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    class func circleLayer(dimension: CGFloat) -> CALayer {
        let layer = CALayer()
        layer.cornerRadius = dimension / 2
        layer.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        layer.backgroundColor = UIColor.lightGray.cgColor
        return layer
    }
}

class ProgressHUD: UIView {
    let smallDotDimension: CGFloat = 11.0
    let mediumDotDimension: CGFloat = 17.0
    let bubbleDimension: CGFloat = 40.0

    let smallDot: CALayer
    let mediumDot: CALayer
    let bubble: CALayer
    
    override init(frame: CGRect) {
        smallDot = CALayer.circleLayer(dimension: smallDotDimension)
        mediumDot = CALayer.circleLayer(dimension: mediumDotDimension)
        bubble = CALayer.circleLayer(dimension: bubbleDimension)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.addSublayer(smallDot)
        layer.addSublayer(mediumDot)
        layer.addSublayer(bubble)
        
        smallDot.frame = CGRect(x: frame.width - smallDotDimension,
                                y: frame.height - smallDotDimension,
                                width: smallDotDimension,
                                height: smallDotDimension)
        mediumDot.frame = CGRect(x: smallDot.frame.origin.x - mediumDotDimension ,
                                 y: smallDot.frame.origin.y - mediumDotDimension,
                                 width: mediumDotDimension,
                                 height: mediumDotDimension)
        bubble.frame = CGRect(x: mediumDot.frame.origin.x - bubbleDimension,
                              y: mediumDot.frame.origin.y - bubbleDimension,
                              width: bubbleDimension,
                              height: bubbleDimension)
    }
    
    func animateIn() {
        animateIn(smallDot, with: 0)
        animateIn(mediumDot, with: 0.5)
        animateIn(bubble, with: 1)
    }
    
    func animateOut() {
        animateOut(bubble, with: 0.0)
        animateOut(mediumDot, with: 0.25)
        animateOut(smallDot, with: 0.5)
    }
    
    private func animateIn(_ layer: CALayer, with delay: Double) {
        layer.opacity = 0
        
        let growAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        growAnimation.duration = 1.0
        growAnimation.values = [NSNumber(value: 0.2),
                                 NSNumber(value: 1.2),
                                 NSNumber(value: 1.0)]
        growAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        growAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 1.0
        opacityAnimation.fromValue = NSNumber(value: 0.0)
        opacityAnimation.toValue = NSNumber(value: 1.0)
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        opacityAnimation.autoreverses = false
        
        growAnimation.beginTime = CACurrentMediaTime() + delay
        opacityAnimation.beginTime = growAnimation.beginTime
        
        layer.add(growAnimation, forKey: "grow")
        layer.add(opacityAnimation, forKey: "opacity")
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = NSNumber(value: 0.98)
        pulseAnimation.toValue = NSNumber(value: 1.1)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        pulseAnimation.beginTime = opacityAnimation.beginTime + opacityAnimation.duration
        
        layer.add(pulseAnimation, forKey: "pulse")
    }
    
    private func animateOut(_ layer: CALayer, with delay: Double) {
        let shrinkAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        shrinkAnimation.duration = 0.5
        shrinkAnimation.values = [NSNumber(value: 1.1),
                                  NSNumber(value: 0.9),
                                  NSNumber(value: 0.2)]
        shrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shrinkAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 0.5
        opacityAnimation.fromValue = NSNumber(value: 1.0)
        opacityAnimation.toValue = NSNumber(value: 0.0)
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        opacityAnimation.autoreverses = false
        
        shrinkAnimation.beginTime = CACurrentMediaTime() + delay
        opacityAnimation.beginTime = shrinkAnimation.beginTime
        
        layer.add(shrinkAnimation, forKey: "shrink")
        layer.add(opacityAnimation, forKey: "opacity")
    }
}
