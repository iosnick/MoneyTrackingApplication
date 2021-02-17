//
//  MTProfileViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class MTProfileViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultUserImage")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white,
                                 text: String(Auth.auth().currentUser?.displayName ?? ""),
                                 font: UIFont.boldSystemFont(ofSize: 32))
        return label
    }()
    private lazy var emailLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(red: 136/255, green: 134/255, blue: 251/255, alpha: 1),
                                 text: String(Auth.auth().currentUser?.email ?? ""),
                                 font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    private lazy var editProfileButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Edit profile", cornerRadius: 15,
                                   titleColor: .white, backgroundColor: UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1),
                                   font: UIFont.systemFont(ofSize: 17), adjustsFontSizeToFitWidth: true)
        button.addTarget(self, action: #selector(self.pushProfileChangeVC), for: .touchUpInside)
        return button
    }()
    private lazy var changePasswordButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Change password", cornerRadius: 15,
                                   titleColor: .white, backgroundColor: UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 0.5),
                                   font: UIFont.systemFont(ofSize: 17), adjustsFontSizeToFitWidth: true)
//        button.addTarget(self, action: #selector(self.pushProfileChangeVC), for: .touchUpInside)
        return button
    }()
    private lazy var notificationButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Notification", cornerRadius: 15,
                                   titleColor: .white, backgroundColor: UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 0.5),
                                   font: UIFont.systemFont(ofSize: 17), adjustsFontSizeToFitWidth: true)
//        button.addTarget(self, action: #selector(self.pushProfileChangeVC), for: .touchUpInside)
        return button
    }()
    private lazy var pincodeButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "PIN code & Face ID", cornerRadius: 15,
                                   titleColor: .white, backgroundColor: UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 0.5),
                                   font: UIFont.systemFont(ofSize: 17), adjustsFontSizeToFitWidth: true)
//        button.addTarget(self, action: #selector(self.pushProfileChangeVC), for: .touchUpInside)
        return button
    }()
    private lazy var signOutButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Sign Out", cornerRadius: 22,
                                   titleColor: .white, backgroundColor: .clear,
                                   font: .boldSystemFont(ofSize: 17), adjustsFontSizeToFitWidth: true)
        button.addTarget(self, action: #selector(self.signOut), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.nameLabel, self.emailLabel,
                               self.editProfileButton, self.changePasswordButton, self.notificationButton,
                               self.pincodeButton, self.signOutButton])
        self.temp()
        self.setupNavigationBarProperties()
        self.addConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.signOutButton.setupBorderGradient(selfSize: self.signOutButton.frame.size,
                                               selfBounds: self.signOutButton.bounds,
                                               borderWidth: 10,
                                               buttonCornerRadius: self.signOutButton.layer.cornerRadius)
    }
    
    // MARK: - Methods
    private func setupNavigationBarProperties() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.clipsToBounds = true
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func temp() {
        if Auth.auth().currentUser?.photoURL != nil {
            print("not nil")
        } else {
            print("nil")
        }
    }
    
    // MARK: - Sign Out
    @objc private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

    
    // MARK: - Push vc
    @objc private func pushProfileChangeVC() {
        let vc = MTChangeProfileViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 138))
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 100))
        
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87.5))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 205))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 39))
        
        constraints.append(emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87.5))
        constraints.append(emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 244))
        constraints.append(emailLabel.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(emailLabel.heightAnchor.constraint(equalToConstant: 17))
        
        constraints.append(editProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(editProfileButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 286))
        constraints.append(editProfileButton.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(editProfileButton.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(changePasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(changePasswordButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 343))
        constraints.append(changePasswordButton.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(changePasswordButton.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(notificationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(notificationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400))
        constraints.append(notificationButton.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(notificationButton.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(pincodeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(pincodeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 457))
        constraints.append(pincodeButton.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(pincodeButton.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 77))
        constraints.append(signOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 538))
        constraints.append(signOutButton.widthAnchor.constraint(equalToConstant: 221))
        constraints.append(signOutButton.heightAnchor.constraint(equalToConstant: 44))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
