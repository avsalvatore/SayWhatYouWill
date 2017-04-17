//
//  BorderedTextField.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

class BorderedTextField: UITextField {
    let borderWidth: CGFloat
    let borderColor: CGColor
    
    init(borderWidth: CGFloat, borderColor: CGColor) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth
    }
    
    lazy var padding: UIEdgeInsets = {
        let pad = self.borderWidth + 2
        return UIEdgeInsets(top: pad,
                            left: pad,
                            bottom: pad,
                            right: pad);
    }()
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
