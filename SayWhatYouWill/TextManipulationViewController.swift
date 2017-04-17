//
//  TextManipulationViewController.swift
//  SayWhatYouWill
//
//  Created by ALEXANDRA SALVATORE on 4/15/17.
//  Copyright © 2017 RowOut. All rights reserved.
//

import UIKit

protocol TextManipulator {
    typealias TextManipluatorCompletion = (_ translatedText: String?, _ error: Error?) -> Void
    func translate(text: String, completion: TextManipluatorCompletion?)
    var viewModel: TextManipulationViewModel { get }
}

enum OutputType {
    case text
    case audio
    case both
}

protocol TextManipulationViewModel {
    var backgroundImage: UIImage? { get }
    var outputType: OutputType { get }
    var inputPlaceholder: String { get }
    var errorMessage: String { get }
    var introMessage: String { get }
}

class TextManipulationViewController: UIViewController {
    //MARK: logic
    fileprivate let notificationCenter = NotificationCenter.default
    fileprivate let textManipulator: TextManipulator
    
    //MARK: UI Components
    fileprivate let bottomPadding: CGFloat = 15.0
    fileprivate var inputNotEditingConstraints = [NSLayoutConstraint]()
    fileprivate lazy var inputBottomConstraint: NSLayoutConstraint = {
        return NSLayoutConstraint(item: self.inputTextField,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: self.view,
                                  attribute: .bottom,
                                  multiplier: 1.0,
                                  constant: -self.bottomPadding)
    }()
    
    fileprivate let placeholderAttributes = [NSFontAttributeName: UIFont.defaultLightFont(of: 20.0),
                                             NSForegroundColorAttributeName: UIColor.gray]
    
    fileprivate let inputTextField: BorderedTextField = {
        let field = BorderedTextField(borderWidth: 3.0, borderColor: UIColor.black.cgColor)
        field.backgroundColor = .white
        field.layer.cornerRadius = 20.0
        field.layer.shadowRadius = 1.0
        field.layer.shadowColor = UIColor.lightGray.cgColor
        field.layer.shadowOpacity = 0.30
        return field
    }()
    
//    fileprivate let outputTextView: UITextView = {
//        let view = UITextView(frame: .zero)
//        view.backgroundColor = .lightGray
//        view.textAlignment = .center
//        view.font = .defaultMediumFont(of: 20.0)
//        view.isEditable = false
//        return view
//    }()
    
    fileprivate let outputTextView: DialogView = DialogView(frame: .zero)

    fileprivate lazy var backgroundImageView = UIImageView(frame: .zero)
    
    fileprivate let overlay: UIView = {
        let blurEffect = UIBlurEffect(style: .light)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
    //MARK: lifecycle
    init(with manipulator: TextManipulator) {
        self.textManipulator = manipulator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        guard let maskImage = UIImage(named: "Rectangle") else { return }
//        let maskView = UIImageView(image: maskImage)
//        maskView.frame = outputTextView.bounds
//        outputTextView.mask = maskView
//        outputTextView.textContainerInset = UIEdgeInsets(top: 10,
//                                                         left: 10,
//                                                         bottom: outputTextView.bounds.height / 2,
//                                                         right: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        registerForNotifications()
        view.backgroundColor = .white
        inputTextField.delegate = self
        inputTextField.attributedPlaceholder = NSAttributedString(string: textManipulator.viewModel.inputPlaceholder,
                                                                  attributes: placeholderAttributes)
//        outputTextView.backgroundColor = .white
//        outputTextView.text = textManipulator.viewModel.introMessage
        view.addSubview(inputTextField.usingConstraints())
        view.addSubview(outputTextView.usingConstraints())
        setupConstraints()
    }
    
    private func setupConstraints() {
        var views = ["input": inputTextField,
                     "output": outputTextView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(15)-[input]-(15)-|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=10)-[input(100)]",
                                                           options: [],
                                                           metrics: nil,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(15)-[output]-(15)-|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(30)-[output(200)]",
                                                           options: [],
                                                           metrics: nil,
                                                           views: views))
        
        if let backgroundImage = textManipulator.viewModel.backgroundImage {
            backgroundImageView.image = backgroundImage
            view.addSubview(backgroundImageView.usingConstraints())
            views["image"] = backgroundImageView
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[output]-[image]",
                                                               options: [],
                                                               metrics: nil,
                                                               views: views))
            
            inputNotEditingConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[image]-[input]",
                                                                                         options: [],
                                                                                         metrics: nil,
                                                                                         views: views))
            
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[image]-(>=1)-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: views))
        }
        view.addConstraints(inputNotEditingConstraints)
        view.addConstraint(inputBottomConstraint)
    }
}

//MARK: Text Field Delegate
extension TextManipulationViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        animateOutputIsProcessing()
        textManipulator.translate(text: text) { [weak self] translatedText, error in
            guard let `self` = self else { return }
            self.removeOutputAnimation()
            if error != nil {
                self.outputTextView.update(with: .dialog(text: self.textManipulator.viewModel.errorMessage))
              //  self.outputTextView.text = self.textManipulator.viewModel.errorMessage
            } else if let resultText = translatedText {
                self.outputTextView.update(with: .dialog(text: resultText))
              //  self.outputTextView.text = translatedText
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

//MARK: Output Animation
extension TextManipulationViewController {
    func animateOutputIsProcessing() {
       // outputTextView.backgroundColor = .lightGray
   //     outputTextView.text = ""
        self.outputTextView.update(with: .thinking)
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = NSNumber(value: 0.95)
        pulseAnimation.toValue = NSNumber(value: 1.0)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        self.outputTextView.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    func removeOutputAnimation() {
        self.outputTextView.layer.removeAllAnimations()
    }
}

//MARK: Keyboard methods
extension TextManipulationViewController {
    
    fileprivate func registerForNotifications() {
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow),
                                       name: NSNotification.Name.UIKeyboardWillShow,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide),
                                       name: NSNotification.Name.UIKeyboardWillHide,
                                       object: nil)
    }
    
    //TODO: finesse animation
    @objc private func keyboardWillShow(note: NSNotification) {
        let frame = keyboardFrame(for: note)
        overlay.frame = view.bounds
        view.addSubview(overlay)
        view.bringSubview(toFront: overlay)
        self.view.bringSubview(toFront: self.inputTextField)
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let `self` = self else { return }
            self.view.removeConstraints(self.inputNotEditingConstraints)
            self.inputBottomConstraint.constant = -frame.height - self.bottomPadding
            self.view.setNeedsLayout()
        }
    }
    
    @objc private func keyboardWillHide(note: NSNotification) {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let `self` = self else { return }
            self.inputBottomConstraint.constant = -self.bottomPadding
            self.view.addConstraints(self.inputNotEditingConstraints)
            self.view.setNeedsLayout()
        }
        overlay.removeFromSuperview()
    }
    
    private func keyboardFrame(for note: NSNotification) -> CGRect {
        guard let userInfo = note.userInfo,
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return CGRect.zero }
        return frame.cgRectValue
    }
}


