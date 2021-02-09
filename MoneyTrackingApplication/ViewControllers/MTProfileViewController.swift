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
        label.setLabelProperties(textColor: UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1),
                                 text: String(Auth.auth().currentUser?.email ?? ""),
                                 font: UIFont.systemFont(ofSize: 14))
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.nameLabel, self.emailLabel])
                
        self.setupNavigationBarProperties()
        self.addConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.frame.size.height = 729
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
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "editIcon"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.pushProfileChangeVC))
        self.navigationItem.rightBarButtonItem = rightButton
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
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
