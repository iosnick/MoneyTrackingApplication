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
        tabBar.frame.size.height = 95
        tabBar.frame.origin.y = view.frame.height - 95
    }
    
    // MARK: - Methods
    private func setupTabBarViewControllers() {
        let homeVC = MTHomeViewController()
        let timeVC = MTTimeViewController()
        let addingVC = MTAddingViewController()
        let bankVC = MTBankViewController()
        let settingsVC = MTSettingsViewController()
        
        self.setViewControllers([homeVC, timeVC, addingVC, bankVC, settingsVC], animated: false)
        self.tabBar.barTintColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.tabBar.clipsToBounds = true
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = false
        
        guard let items = self.tabBar.items else { return }
        let images = ["homeIcon", "timeIcon", "addingIcon", "bankIcon", "settingsIcon"]
        for x in 0...4 {
            items[x].image = UIImage(named: images[x])
        }
        
    }
    private func setupProperties() {
        
    }
}
