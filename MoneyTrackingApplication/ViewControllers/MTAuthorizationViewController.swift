//
//  MTAuthorizationViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit
import FirebaseAuth
import TransitionButton

class MTAuthorizationViewController: UIViewController {
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
    private lazy var userEmailTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Email", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "emailIcon")
        textField.textContentType = .name
        return textField
    }()
    private lazy var userPasswordTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(isSecureTextEntry: true, placeHolderText: "Password", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIcon(named: "lockIcon")
        textField.addRigthIcon()
        textField.textContentType = .password
        return textField
    }()
    private lazy var signInButton: TransitionButton = {
        let button = TransitionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(self.userAuth), for: .touchUpInside)
        return button
    }()
    private lazy var signUpLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Don’t have an account?", font: .systemFont(ofSize: 15))
        return label
    }()
    private lazy var signUpButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setButtonProperties(title: "Sign Up",
                                   titleColor: UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1),
                                   font: UIFont.systemFont(ofSize: 15))
        button.addTarget(self, action: #selector(self.openRegisterVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.welcomeBackLabel, self.userEmailTextField, self.userPasswordTextField,
                               self.signUpButton, self.signInButton, self.signUpLabel])
        
        self.userEmailTextField.delegate = self
        self.userPasswordTextField.delegate = self
        
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
        
        self.addGradient()    }

    // MARK: - Methods
    private func addGradient() {
        self.signInButton.setupGradient(buttonCornerRadius: self.signInButton.layer.cornerRadius, bounds: self.signInButton.bounds)
    }
    
    // MARK: - Alerts
    private func showAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Just fill all of the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func showAuthErrorAlert(error: String) {
        let alert = UIAlertController(title: "Oops!",
                                      message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Register methods
    @objc private func userAuth() {
        self.signInButton.startAnimation()
        
        let email = userEmailTextField.text!
        let password = userPasswordTextField.text!
        
        if !email.isEmpty, !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
                guard let self = self else { return }
                if error == nil {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.signInButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                            let vc = MTTabBarViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.signInButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 1) { }
                    }
                    
                    self.showAuthErrorAlert(error: error!.localizedDescription)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.signInButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 1) { }
            }
            
            self.showAlert()
        }
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
        
        constraints.append(userEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userEmailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 361))
        constraints.append(userEmailTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userEmailTextField.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(userPasswordTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 409))
        constraints.append(userPasswordTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(userPasswordTextField.heightAnchor.constraint(equalToConstant: 35))
        
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
    
    // MARK: - Keyboard methods
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

extension MTAuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}
