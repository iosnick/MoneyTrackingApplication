//
//  MTTabBarViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit

class MTTabBarViewController: UITabBarController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabBarViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.frame.size.height = 95
    }
    
    // MARK: - Methods
    private func setupTabBarViewControllers() {
        let homeVC = MTHomeViewController()
        let timeVC = MTTimeViewController()
        let addingVC = MTAddingViewController()
        let bankVC = MTBankViewController()
        let profileVC = UINavigationController(rootViewController: MTProfileViewController())
        
        self.setViewControllers([homeVC, timeVC, addingVC, bankVC, profileVC], animated: false)
        self.tabBar.barTintColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.tabBar.clipsToBounds = true
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.tintColor = UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1)
        self.tabBar.isTranslucent = false
        
        homeVC.tabBarItem.image = UIImage(named: "homeIcon")
        timeVC.tabBarItem.image = UIImage(named: "timeIcon")
        addingVC.tabBarItem.image = UIImage(named: "addingIcon")
        bankVC.tabBarItem.image = UIImage(named: "bankIcon")
        profileVC.tabBarItem.image = UIImage(named: "settingsIcon")
    }
}
