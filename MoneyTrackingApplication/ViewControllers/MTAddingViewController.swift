//
//  MTAddingViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit

class MTAddingViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var addBalanceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 136/255, green: 134/255, blue: 251/255, alpha: 1)
        button.setTitle("Add to Balance", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    private lazy var addGoalButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 136/255, green: 134/255, blue: 251/255, alpha: 1)
        button.setTitle("Add to Goal", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.backButtonPresed), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backIcon")
        imageView.frame = .init(x: 20, y: 0, width: 49, height: 49)
        
        button.addSubview(imageView)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBlur()
        
        self.view.addSubviews([self.addBalanceButton, self.addGoalButton, self.backButton])
        
        self.addConstraints()
    }
    
    // MARK: - Methods
    @objc private func backButtonPresed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add

        constraints.append(addBalanceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23))
        constraints.append(addBalanceButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 570))
        constraints.append(addBalanceButton.widthAnchor.constraint(equalToConstant: 159))
        constraints.append(addBalanceButton.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(addGoalButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 193))
        constraints.append(addGoalButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 570))
        constraints.append(addGoalButton.widthAnchor.constraint(equalToConstant: 159))
        constraints.append(addGoalButton.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143))
        constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 646))
        constraints.append(backButton.widthAnchor.constraint(equalToConstant: 48))
        constraints.append(backButton.heightAnchor.constraint(equalToConstant: 48))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
