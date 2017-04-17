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
    case none(text: String?)
}

class DialogView: UIView {
    fileprivate var viewType: DialogViewType = .none(text: nil)
    
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
    
    fileprivate lazy var thinkingHUD: ProgressHUD = {
        return ProgressHUD(frame: self.bounds)
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[output]-(60)-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: views))
    }
    
    func update(with type: DialogViewType) {
        switch viewType {
        case .thinking:
            thinkingHUD.animateOut()
        case .none, .dialog(_):
            break
        }
        switch type {
        case .thinking:
            backgroundImageView.isHidden = true
            outputTextView.isHidden = true
            outputTextView.text = nil
            thinkingHUD.removeFromSuperview()
            thinkingHUD = ProgressHUD(frame: self.bounds)
            addSubview(thinkingHUD)
            thinkingHUD.animateIn()
        case let .none(text):
            thinkingHUD.isHidden = true
            backgroundImageView.isHidden = true
            outputTextView.isHidden = false
            outputTextView.text = text
        case let .dialog(text):
            thinkingHUD.isHidden = true
            backgroundImageView.isHidden = false
            outputTextView.isHidden = false
            outputTextView.text = text
        }
        viewType = type
    }
}

