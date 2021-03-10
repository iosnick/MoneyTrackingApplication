//
//  MTBankViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit

class MTBankViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var label: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Come back later :)",
                                 textAlignment: .center, font: .boldSystemFont(ofSize: 40), lines: 1)
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubview(self.label)
        
        self.addConstraints()
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add

        constraints.append(label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(label.topAnchor.constraint(equalTo: view.topAnchor, constant: 300))
        constraints.append(label.widthAnchor.constraint(equalToConstant: 355))
        constraints.append(label.heightAnchor.constraint(equalToConstant: 100))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
