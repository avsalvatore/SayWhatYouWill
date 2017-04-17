//
//  Font+SWYW.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func defaultLightFont(of pointSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Light", size: pointSize) {
            return font
        }
        return UIFont.systemFont(ofSize: pointSize)
    }
    
    class func defaultMediumFont(of pointSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Medium", size: pointSize) {
            return font
        }
        return UIFont.systemFont(ofSize: pointSize)
    }
}
