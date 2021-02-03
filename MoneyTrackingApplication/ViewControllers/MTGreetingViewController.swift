//
//  MTGreetingViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 02.02.2021.
//

import UIKit

class MTGreetingViewController: UIViewController {
    // MARK: - Variables
    lazy var signUpButton: MTSignUpButton = {
        let button = MTSignUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Up", cornerRadius: 25)
        return button
    }()
    lazy var greetingImageView: MTGreetingVCImageView = {
        let imageView = MTGreetingVCImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        
        self.view.addSubview(self.signUpButton)
        self.view.addSubview(self.greetingImageView)
        self.addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16))
        constraints.append(signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 669))
        constraints.append(signUpButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(greetingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170))
        constraints.append(greetingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170))
        constraints.append(greetingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 77))
        constraints.append(greetingImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(greetingImageView.widthAnchor.constraint(equalToConstant: 35))


        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
    
}


