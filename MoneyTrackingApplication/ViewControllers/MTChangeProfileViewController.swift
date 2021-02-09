//
//  MTChangeProfileViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 09.02.2021.
//

import UIKit

class MTChangeProfileViewController: UIViewController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        
        self.setupNavigationBarProperties()
    }
    
    // MARK: - Methods
    private func setupNavigationBarProperties() {
        self.title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
