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
                                textFont: UIFont = .systemFont(ofSize: 15),
                                cornerRadius: CGFloat = 0,
                                borderColor: CGColor = UIColor.white.cgColor,
                                borderWidth: CGFloat = 1) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.5),
                                                                     NSAttributedString.Key.font: UIFont(name: "Montserrat",
                                                                                                         size: placeHolderTextSize) as Any])
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = cornerRadius
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
        leftView.frame = CGRect(x: 0, y: 0, width: 37, height: 26)
        leftImageView.frame = CGRect(x: 10, y: 4, width: 16, height: 16)
        self.addSubview(leftView)
        self.leftView = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func addRigthIcon() {
        let rightView = UIView()
        rightView.addSubview(self.textFieldEyeButton)
        rightView.frame = CGRect(x: 0, y: 0, width: 28.5, height: 25)
        textFieldEyeButton.frame = CGRect(x: 2, y: 4, width: 16, height: 16)
        self.addSubview(rightView)
        self.rightView = rightView
        self.rightViewMode = UITextField.ViewMode.always
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

