//
//  MTMainViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 05.02.2021.
//

import UIKit
import Firebase
import FirebaseAuth


class MTMainViewController: UIViewController {
    // MARK: - Reference to database
    let ref = Database.database().reference()
    
    // MARK: - Properties
    private var username = ""
    
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
        label.setLabelProperties(textColor: .blue,
                                 textAlignment: .left,
                                 font: UIFont.systemFont(ofSize: 31))
        return label
    }()
    
    // MARK: - Life cicle
    override func loadView() {
        super.loadView()
        
        self.ref.child("users").child(Auth.auth().currentUser!.uid).observe(.value, with: { snapshot in
            let userInfo = snapshot.value as? NSDictionary
            let userName = userInfo!["name"] as! String
            self.nameLabel.text = "Hello, \(userName)"
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubviews([self.nameLabel, self.button])
        self.addConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Open View Controllers
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 81))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 174))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100))
        constraints.append(button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150))
        constraints.append(button.widthAnchor.constraint(equalToConstant: 174))
        constraints.append(button.heightAnchor.constraint(equalToConstant: 38))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
