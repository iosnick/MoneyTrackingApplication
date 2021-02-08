//
//  AppDelegate.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 02.02.2021.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            if user != nil {
                self.showTabBarViewController()
            } else {
                self.showGreetingViewController()
            }
        }
        
        return true
    }
    
    func showGreetingViewController() {
        let greetingVC = MTGreetingViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = greetingVC
        self.window?.makeKeyAndVisible()
    }

    func showTabBarViewController() {
        let tabBarVC = MTTabBarViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
    }
}
