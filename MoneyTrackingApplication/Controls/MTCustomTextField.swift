//
//  MTCustomTextField.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 04.02.2021.
//

import UIKit

class MTCustomTextField: UITextField {
    // MARK: - View Life Cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setTextFieldProperties(backgroundColor: CGColor = UIColor.clear.cgColor,
                                isSecureTextEntry: Bool = false,
                                placeHolderText: String,
                                textColor: UIColor = .white,
                                placeHolderTextSize: CGFloat = 12,
                                returnKeyType: UIReturnKeyType = .done,
                                textFont: UIFont = .systemFont(ofSize: 15)) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.75),
                                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: placeHolderTextSize)])
        self.font = textFont
        self.layer.backgroundColor = backgroundColor
        self.textColor = textColor
        self.isSecureTextEntry = isSecureTextEntry
        self.returnKeyType = returnKeyType
    }
    
    // MARK: - Add icons in textField
    func addLeftIcon(named: String) {
        let leftImageView = UIImageView()
        leftImageView.image = UIImage(named: named)
        let leftView = UIView()
        leftView.addSubview(leftImageView)
        leftView.frame = CGRect(x: 0, y: 0, width: 28.5, height: 25)
        leftImageView.frame = CGRect(x: 6, y: 4, width: 16, height: 16)
        self.addSubview(leftView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func addRigthIcon() {
        let rightView = UIView()
        rightView.addSubview(self.textFieldEyeButton)
        rightView.frame = CGRect(x: 0, y: 0, width: 28.5, height: 25)
        textFieldEyeButton.frame = CGRect(x: 6, y: 4, width: 16, height: 16)
        self.addSubview(rightView)
        self.rightView = rightView
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    // MARK: - Add bottom border
    func addBottomBorder(widthSelfTextField: CGFloat, heidthSelfTextField:CGFloat) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: heidthSelfTextField + 4, width: widthSelfTextField, height: 1)
        bottomLine.backgroundColor = UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
    // MARK: - Eye button for password
    private lazy var textFieldEyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eyeIcon"), for: .normal)
        button.addTarget(self, action: #selector(self.preesEyeButton), for: .touchUpInside)
        return button
    }()
    
    @objc func preesEyeButton() {
        if self.isSecureTextEntry {
            self.textFieldEyeButton.setImage(UIImage(named: "eyeBlockIcon"), for: .normal)
            self.isSecureTextEntry = false
        } else {
            self.textFieldEyeButton.setImage(UIImage(named: "eyeIcon"), for: .normal)
            self.isSecureTextEntry = true
        }
    }
}

