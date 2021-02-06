//
//  MTAuthorizationViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTAuthorizationViewController: UIViewController, UITextFieldDelegate {
    // MARK: - GUI Variables
    private lazy var welcomeBackLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white,
                                 text: "Welcome\nBack",
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
        textField.textContentType = .name
        textField.addBottomBorder(widthSelfTextField: 300, heidthSelfTextField: 26)
        return textField
    }()
    private lazy var userPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Password")
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.textContentType = .password
        textField.addBottomBorder(widthSelfTextField: 300, heidthSelfTextField: 26)
        return textField
    }()
    private lazy var signInButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        //        button.addTarget(self, action: #selector(self.openAuthVC), for: .touchUpInside)
        return button
    }()
    private lazy var signUpLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Don’t have an account?", font: .systemFont(ofSize: 15))
        return label
    }()
    private lazy var signUpButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setButtonProperties(title: "Sign Up",
                                   titleColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0),
                                   font: UIFont.systemFont(ofSize: 15))
        button.addTarget(self, action: #selector(self.openRegisterVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        
        self.userNameTextField.delegate = self
        self.userPasswordTextField.delegate = self
        self.keyboardHideWhenTappedAround()
        
        self.view.addSubviews([self.welcomeBackLabel, self.userNameTextField, self.userPasswordTextField,
                               self.signUpButton, self.signInButton, self.signUpLabel])
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Open View Controllers
    @objc private func openRegisterVC() {
        let vc = MTRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(welcomeBackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47))
        constraints.append(welcomeBackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 248))
        constraints.append(welcomeBackLabel.widthAnchor.constraint(equalToConstant: 170))
        constraints.append(welcomeBackLabel.heightAnchor.constraint(equalToConstant: 86))
        
        constraints.append(userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 371))
        constraints.append(userNameTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userNameTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 418))
        constraints.append(userPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userPasswordTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38))
        constraints.append(signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 479))
        constraints.append(signInButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61))
        constraints.append(signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 544))
        constraints.append(signUpLabel.widthAnchor.constraint(equalToConstant: 196))
        constraints.append(signUpLabel.heightAnchor.constraint(equalToConstant: 18))
        
        constraints.append(signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor, constant: 0))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 544))
        constraints.append(signUpButton.widthAnchor.constraint(equalToConstant: 53))
        constraints.append(signUpButton.heightAnchor.constraint(equalToConstant: 18))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Methods
    @objc private func keyboardWillShow(_ notification: Notification) { }
    
    @objc private func keyboardWillHide() { }
    
    // MARK: - Observers
    private func registerForKeyboardNotifications() {
        self.unregisterFromKeyboardNotifications()
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}

