//
//  MTGreetingViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 02.02.2021.
//

import UIKit

class MTGreetingViewController: UIViewController {
    // MARK: - Variables
    lazy var welcomeLabel: MTGreetingVCLabel = {
        let label = MTGreetingVCLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Welcome to", font: .systemFont(ofSize: 24))
        return label
    }()
    lazy var secondWelcomeLabel: MTGreetingVCLabel = {
        let label = MTGreetingVCLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(red: 68/255, green: 71/255, blue: 234/255, alpha: 1),
                                 text: "Money Tracking",
                                 font: .systemFont(ofSize: 24))
        return label
    }()
    lazy var thirdWelcomeLabel: MTGreetingVCLabel = {
        let label = MTGreetingVCLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Save your money", font: .systemFont(ofSize: 27))
        return label
    }()
    lazy var fourthWelcomeLabel: MTGreetingVCLabel = {
        let label = MTGreetingVCLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(red: 169/255, green: 169/255, blue: 185/255, alpha: 1),
                                 text: "Manage your finance, control expenses, plan your budget and save your money for grand future purposes",
                                 font: .systemFont(ofSize: 15),
                                 numberOfLines: 3)
        return label
    }()
    lazy var signInLabel: MTGreetingVCLabel = {
        let label = MTGreetingVCLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Already have an account?", font: .systemFont(ofSize: 15))
        return label
    }()
    lazy var signUpButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        return button
    }()
    lazy var signInButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setButtonProperties(title: "Sign In",
                                   titleColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0),
                                   font: UIFont.systemFont(ofSize: 15))
        return button
    }()
    lazy var greetingImageView: MTGreetingVCImageView = {
        let imageView = MTGreetingVCImageView()
        imageView.setImage(named: "greetingVCImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var secondGreetingImageView: MTGreetingVCImageView = {
        let imageView = MTGreetingVCImageView()
        imageView.setImage(named: "secondGreetingVCImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        
        self.addSubviews()
        self.addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.signInButton)
        self.view.addSubview(self.signInLabel)
        self.view.addSubview(self.fourthWelcomeLabel)
        self.view.addSubview(self.thirdWelcomeLabel)
        self.view.addSubview(self.secondGreetingImageView)
        self.view.addSubview(self.secondWelcomeLabel)
        self.view.addSubview(self.welcomeLabel)
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.greetingImageView)
    }
    
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


