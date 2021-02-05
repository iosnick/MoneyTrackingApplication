//
//  MTRegisterViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 04.02.2021.
//

import UIKit

class MTRegisterViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var createAccountLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white,
                                 text: "Create\nAccount",
                                 textAlignment: .left,
                                 font: .systemFont(ofSize: 35),
                                 lines: 2)
        return label
    }()
    private lazy var userNameTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "User name")
        textField.addLeftIcon(named: "userIcon")
        textField.addBottomBorder(widthSelfTextField: 300, heidthSelfTextField: 26)
        return textField
    }()
    private lazy var userPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Password")
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.addBottomBorder(widthSelfTextField: 300, heidthSelfTextField: 26)
        return textField
    }()
    private lazy var userRepeatPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Repeat password")
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.addBottomBorder(widthSelfTextField: 300, heidthSelfTextField: 26)
        return textField
    }()
    private lazy var signUpButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
//        button.addTarget(self, action: #selector(self.openAuthVC), for: .touchUpInside)
        return button
    }()
    private lazy var signInLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Already have an account?", font: .systemFont(ofSize: 15))
        return label
    }()
    private lazy var signInButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setButtonProperties(title: "Sign In",
                                   titleColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0),
                                   font: UIFont.systemFont(ofSize: 15))
        button.addTarget(self, action: #selector(self.openAuthVC), for: .touchUpInside)
        return button
    }()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.06
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "backgroundImage")
        return imageView
    }()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        
        self.view.addSubviews([self.backgroundImageView ,self.createAccountLabel, self.userNameTextField,
                               self.userRepeatPasswordTextField, self.signUpButton, self.signInLabel,
                               self.signInButton, self.userPasswordTextField])
        self.addConstraints()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Open View Controllers
    @objc private func openAuthVC() {
        let vc = MTAuthorizationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47))
        constraints.append(createAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 199))
        constraints.append(createAccountLabel.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(createAccountLabel.heightAnchor.constraint(equalToConstant: 86))
        
        constraints.append(userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 322))
        constraints.append(userNameTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userNameTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 369))
        constraints.append(userPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userPasswordTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(userRepeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userRepeatPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 416))
        constraints.append(userRepeatPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userRepeatPasswordTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 479))
        constraints.append(signUpButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61))
        constraints.append(signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 544))
        constraints.append(signInLabel.widthAnchor.constraint(equalToConstant: 196))
        constraints.append(signInLabel.heightAnchor.constraint(equalToConstant: 18))
        
        constraints.append(signInButton.leadingAnchor.constraint(equalTo: signInLabel.trailingAnchor, constant: 0))
        constraints.append(signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 544))
        constraints.append(signInButton.widthAnchor.constraint(equalToConstant: 53))
        constraints.append(signInButton.heightAnchor.constraint(equalToConstant: 18))
        
        constraints.append(backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -170))
        constraints.append(backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 230))
        constraints.append(backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}