//
//  MTMainViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 05.02.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class MTMainViewController: UIViewController {
    // MARK: - Variables
    
    // MARK: - GUI Variables
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .blue,
                                 text: "Hello, ",
                                 textAlignment: .left,
                                 font: UIFont.systemFont(ofSize: 31))
        return label
    }()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubviews([self.nameLabel])
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
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
