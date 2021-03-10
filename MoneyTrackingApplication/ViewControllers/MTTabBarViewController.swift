//
//  MTTabBarViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit

class MTTabBarViewController: UITabBarController {
    // MARK: - GUI Variables
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.presentAddingVC), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addingIcon")
        imageView.frame = .init(x: 20, y: 0, width: 49, height: 49)
        
        button.addSubview(imageView)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.view.addSubview(self.button)
            
        self.setupTabBarViewControllers()
        self.addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tabBar.frame.size.height = 100
        self.tabBar.frame.origin.y = view.frame.height - 100
    }
    
    // MARK: - Methods
    @objc private func presentAddingVC() {
        let vc = MTAddingViewController()
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setupTabBarViewControllers() {
        let homeVC = MTHomeViewController()
        let timeVC = MTTimeViewController()
        let addingVC = MTAddingViewController()
        let bankVC = MTBankViewController()
        let profileVC = UINavigationController(rootViewController: MTProfileViewController())
        
        self.setViewControllers([homeVC, timeVC, addingVC, bankVC, profileVC], animated: false)
        self.tabBar.barTintColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.tabBar.clipsToBounds = true
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.tintColor = UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1)
        self.tabBar.isTranslucent = false
        
        homeVC.tabBarItem.image = UIImage(named: "homeIcon")
        timeVC.tabBarItem.image = UIImage(named: "timeIcon")
        bankVC.tabBarItem.image = UIImage(named: "slashIcon")
        profileVC.tabBarItem.image = UIImage(named: "settingsIcon")
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add

        constraints.append(button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143))
        constraints.append(button.topAnchor.constraint(equalTo: view.topAnchor, constant: 715))
        constraints.append(button.widthAnchor.constraint(equalToConstant: 89))
        constraints.append(button.heightAnchor.constraint(equalToConstant: 89))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - UITabBarControllerDelegate
extension MTTabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }

}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.5, y: 1.5)
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

}
