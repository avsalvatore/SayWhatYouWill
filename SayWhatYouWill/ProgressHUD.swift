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
        return layer
    }
}

class ProgressHUD: UIView {
    let dotDimension: CGFloat
    let dotOne: CALayer
    let dotTwo: CALayer
    let dotThree: CALayer
    
    override init(frame: CGRect) {
        dotDimension = min(frame.height, frame.width / 3)
        dotOne = CALayer.circleLayer(dimension: dotDimension)
        dotTwo = CALayer.circleLayer(dimension: dotDimension)
        dotThree = CALayer.circleLayer(dimension: dotDimension)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
}
