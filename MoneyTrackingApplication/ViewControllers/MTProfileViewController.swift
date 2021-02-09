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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.profileImageView])
                
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
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
