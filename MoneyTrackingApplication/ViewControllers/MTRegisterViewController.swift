//
//  MTRegisterViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 04.02.2021.
//

import UIKit
import FirebaseAuth

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
        textField.setTextFieldProperties(placeHolderText: "User Name", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "userIcon")
        textField.textContentType = .name
        return textField
    }()
    private lazy var userEmailTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Email", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "emailIcon")
        textField.textContentType = .emailAddress
        return textField
    }()
    private lazy var userPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Password", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.textContentType = .newPassword
        return textField
    }()
    private lazy var userRepeatPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Repeat password", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.textContentType = .newPassword
        return textField
    }()
    private lazy var signUpButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.userRegister), for: .touchUpInside)
        return button
    }()
    private lazy var signInLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Already have an account?", font: .systemFont(ofSize: 15))
        return label
    }()
    private lazy var signInButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setButtonProperties(title: "Sign In",
                                   titleColor: UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1),
                                   font: UIFont.systemFont(ofSize: 15))
        button.addTarget(self, action: #selector(self.openAuthVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.createAccountLabel, self.userNameTextField, self.userEmailTextField,
                               self.userRepeatPasswordTextField, self.signUpButton, self.signInLabel,
                               self.signInButton, self.userPasswordTextField])
        
        self.userNameTextField.delegate = self
        self.userEmailTextField.delegate = self
        self.userPasswordTextField.delegate = self
        self.userRepeatPasswordTextField.delegate = self
        
        self.keyboardHideWhenTappedAround()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.addGradient()
    }
    
    // MARK: - Methods
    private func addGradient() {
        self.signUpButton.setupGradient(buttonCornerRadius: self.signUpButton.layer.cornerRadius, bounds: self.signUpButton.bounds)
    }
    
    // MARK: - Alerts
    private func showAlert() {
        let alert = UIAlertController(title: "Oops!",
                                      message: "Just fill all of the fields or password mismatch", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func showRegisterErrorAlert(error: String) {
        let alert = UIAlertController(title: "Oops!",
                                      message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Register methods
    @objc private func userRegister() {
        let name = userNameTextField.text!
        let email = userEmailTextField.text!
        let password = userPasswordTextField.text!
        let repeatPassword = userRepeatPasswordTextField.text!
        
        if !name.isEmpty, !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty, password == repeatPassword {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                guard let self = self else { return }
                if error == nil {
                    let changeRequest = result?.user.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges(completion: nil)
                    
                    let vc = MTTabBarViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showRegisterErrorAlert(error: error!.localizedDescription)
                }
            }
        } else {
            self.showAlert()
        }
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
        constraints.append(createAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 154))
        constraints.append(createAccountLabel.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(createAccountLabel.heightAnchor.constraint(equalToConstant: 86))
        
        constraints.append(userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userNameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 314))
        constraints.append(userNameTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userNameTextField.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(userEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userEmailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 361))
        constraints.append(userEmailTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userEmailTextField.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 408))
        constraints.append(userPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userPasswordTextField.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(userRepeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userRepeatPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 455))
        constraints.append(userRepeatPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userRepeatPasswordTextField.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 527))
        constraints.append(signUpButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 61))
        constraints.append(signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 592))
        constraints.append(signInLabel.widthAnchor.constraint(equalToConstant: 196))
        constraints.append(signInLabel.heightAnchor.constraint(equalToConstant: 18))
        
        constraints.append(signInButton.leadingAnchor.constraint(equalTo: signInLabel.trailingAnchor, constant: 0))
        constraints.append(signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 592))
        constraints.append(signInButton.widthAnchor.constraint(equalToConstant: 53))
        constraints.append(signInButton.heightAnchor.constraint(equalToConstant: 18))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Keyboard Methods
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

extension MTRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}
