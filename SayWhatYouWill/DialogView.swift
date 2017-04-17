//
//  DialogView.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/16/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import Foundation
import UIKit

enum DialogViewType {
    case dialog(text: String)
    case thinking
    case none
}

class DialogView: UIView {
    fileprivate let viewType: DialogViewType = .none
    
    fileprivate let outputTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.font = .defaultMediumFont(of: 20.0)
        view.isEditable = false
        return view
    }()
    
    fileprivate let backgroundImageView: UIImageView = {
        let image = UIImage(named: "Rectangle")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(backgroundImageView.usingConstraints())
        addSubview(outputTextView.usingConstraints())
        setupConstraints()
        update(with: viewType)
    }
    
    func setupConstraints() {
        let views = ["image": backgroundImageView,
                     "output": outputTextView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[output]-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[output]-(45)-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
    }
    
    func update(with type: DialogViewType) {
        switch type {
        case .none:
            backgroundImageView.isHidden = true
            outputTextView.isHidden = true
            fallthrough
        case .thinking:
            break
        case let .dialog(text):
            backgroundImageView.isHidden = false
            outputTextView.isHidden = false
            outputTextView.text = text
        }
    }
    
}
