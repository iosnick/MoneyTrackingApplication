//
//  MTHomeViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 05.02.2021.
//

import UIKit
import FirebaseAuth


class MTHomeViewController: UIViewController {
    // MARK: - Temp button
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BACK", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        return button
    }()
    
    @objc private func back() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }

    // MARK: - GUI Variables
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white,
                                 text: "Welcome",
                                 textAlignment: .left,
                                 font: UIFont.boldSystemFont(ofSize: 31))
        return label
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultUserImage")
        imageView.layer.cornerRadius = 28
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Life cycle
//    override func loadView() {
//        super.loadView()
//
//                self.ref.child("users").child(Auth.auth().currentUser!.uid).observe(.value, with: { snapshot in
//            let userInfo = snapshot.value as? NSDictionary
//            let userName = userInfo!["name"] as! String
//            self.nameLabel.text = "Hello, \(userName)"
//        })
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.nameLabel, self.button, self.profileImageView])
        
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        self.nameLabel.text = "Hello, \(userName)"
    }
    
    // MARK: - Methods
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 81))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 270))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100))
        constraints.append(button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150))
        constraints.append(button.widthAnchor.constraint(equalToConstant: 174))
        constraints.append(button.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 72))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 295))
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 56))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 56))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
