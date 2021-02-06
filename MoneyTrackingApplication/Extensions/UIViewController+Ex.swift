//
//  UIViewController+Ex.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 06.02.2021.
//

import UIKit

// MARK: - Tap Gesture
extension UIViewController {
    func keyboardHideWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
