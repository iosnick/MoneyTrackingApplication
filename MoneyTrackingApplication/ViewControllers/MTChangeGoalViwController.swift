//
//  MTChangeGoalViwController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 11.03.2021.
//

import UIKit

class MTChangeGoalViwController: UIViewController {
    // MARK: - GUI Variables
//    private lazy var Label: MTCustomLabel = {
//        let label = MTCustomLabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private lazy var addButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Add",
                                   cornerRadius: 20,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.changeGoal), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 27/255, green: 30/255, blue: 37/255, alpha: 1)
        self.view.addSubviews([self.addButton])
        
        self.addConstraints()
    }
    
    // MARK: - Methods
    @objc private func changeGoal() {
        let vc = MTTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        
//        CoreDataManager.shared.remove(from: "Balance")
//        CoreDataManager.shared.writeDataInBalance(mainBalance: 10, income: 0, outcome: 0)
        let array = CoreDataManager.shared.readGoals()
        print(array)
        
        self.present(vc, animated: false, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 692))
        constraints.append(addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52))
        constraints.append(addButton.widthAnchor.constraint(equalToConstant: 272))
        constraints.append(addButton.heightAnchor.constraint(equalToConstant: 44))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
