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
        return button
    }()
    lazy var greetingImageView: MTGreetingVCImageView = {
        let imageView = MTGreetingVCImageView()
        return imageView
    }()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.signUpButton)
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        self.signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                                        self.signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                                        self.signUpButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 669),
                                        self.signUpButton.heightAnchor.constraint(equalToConstant: 50)])
        self.view.addSubview(self.greetingImageView)
        self.greetingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        self.greetingImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 170),
                                        self.greetingImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -170),
                                        self.greetingImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 77),
                                        self.greetingImageView.heightAnchor.constraint(equalToConstant: 30),
                                        self.greetingImageView.widthAnchor.constraint(equalToConstant: 35)])
    }
}


