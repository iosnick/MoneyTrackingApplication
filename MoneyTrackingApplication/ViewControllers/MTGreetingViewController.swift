//
//  MTGreetingViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 02.02.2021.
//

import UIKit

class MTGreetingViewController: UIViewController {
    // MARK: - Variables
    private var buttonBounds: CGRect = .null
    
    // MARK: - GUI Variables
    private lazy var welcomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Welcome to", font: .systemFont(ofSize: 24))
        return label
    }()
    private lazy var secondWelcomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(red: 68/255, green: 71/255, blue: 234/255, alpha: 1),
                                 text: "Money Tracking",
                                 font: .systemFont(ofSize: 24))
        return label
    }()
    private lazy var thirdWelcomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Save your money", font: .systemFont(ofSize: 27))
        return label
    }()
    private lazy var fourthWelcomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(red: 169/255, green: 169/255, blue: 185/255, alpha: 1),
                                 text: "Manage your finance, control expenses, plan your budget and save your money for grand future purposes",
                                 font: .systemFont(ofSize: 15),
                                 lines: 3)
        return label
    }()
    private lazy var signUpButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.openRegisterVC), for: .touchUpInside)
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
    private lazy var greetingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greetingVCImage")?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var secondGreetingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "secondGreetingVCImage")?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.signInButton, self.signInLabel, self.fourthWelcomeLabel, self.thirdWelcomeLabel,
                               self.secondGreetingImageView, self.secondWelcomeLabel, self.welcomeLabel,
                               self.signUpButton, self.greetingImageView])
        
        self.addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.signUpButton.setupGradient(buttonCornerRadius: self.signUpButton.layer.cornerRadius, bounds: self.signUpButton.bounds)
    }
    
    // MARK: - Open View Controllers
    @objc private func openAuthVC() {
        let vc = MTAuthorizationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func openRegisterVC() {
        let vc = MTRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16))
        constraints.append(signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 669))
        constraints.append(signUpButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(greetingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170))
        constraints.append(greetingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 77))
        constraints.append(greetingImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(greetingImageView.widthAnchor.constraint(equalToConstant: 35))

        constraints.append(welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90))
        constraints.append(welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128))
        constraints.append(welcomeLabel.widthAnchor.constraint(equalToConstant: 195))
        constraints.append(welcomeLabel.heightAnchor.constraint(equalToConstant: 29))
        
        constraints.append(secondWelcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90))
        constraints.append(secondWelcomeLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 0))
        constraints.append(secondWelcomeLabel.widthAnchor.constraint(equalToConstant: 195))
        constraints.append(secondWelcomeLabel.heightAnchor.constraint(equalToConstant: 29))
        
        constraints.append(secondGreetingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30))
        constraints.append(secondGreetingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 234))
        constraints.append(secondGreetingImageView.heightAnchor.constraint(equalToConstant: 212))
        constraints.append(secondGreetingImageView.widthAnchor.constraint(equalToConstant: 312))
        
        constraints.append(thirdWelcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69))
        constraints.append(thirdWelcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 483))
        constraints.append(thirdWelcomeLabel.widthAnchor.constraint(equalToConstant: 236))
        constraints.append(thirdWelcomeLabel.heightAnchor.constraint(equalToConstant: 33))
        
        constraints.append(fourthWelcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32))
        constraints.append(fourthWelcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 542))
        constraints.append(fourthWelcomeLabel.widthAnchor.constraint(equalToConstant: 310))
        constraints.append(fourthWelcomeLabel.heightAnchor.constraint(equalToConstant: 58))
        
        constraints.append(signInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60))
        constraints.append(signInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 740))
        constraints.append(signInLabel.widthAnchor.constraint(equalToConstant: 196))
        constraints.append(signInLabel.heightAnchor.constraint(equalToConstant: 18))
        
        constraints.append(signInButton.leadingAnchor.constraint(equalTo: signInLabel.trailingAnchor, constant: 0))
        constraints.append(signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 740))
        constraints.append(signInButton.widthAnchor.constraint(equalToConstant: 53))
        constraints.append(signInButton.heightAnchor.constraint(equalToConstant: 18))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
    
}


