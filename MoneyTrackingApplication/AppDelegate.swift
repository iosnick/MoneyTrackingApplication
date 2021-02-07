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
            if user == nil {
                self.showGreetingViewController()
            } else {
                self.showMainViewController()
            }
        }
        
        return true
    }
    
    func showGreetingViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MTGreetingViewController()
        self.window?.makeKeyAndVisible()
    }
    
    func showMainViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MTMainViewController()
        self.window?.makeKeyAndVisible()
    }
}
