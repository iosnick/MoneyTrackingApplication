//
//  UIView+Ex.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 04.02.2021.
//

import UIKit

extension UIView {
    func  addSubviews(_ views: [UIView]) {
        views.forEach{ eachView in
            self.addSubview(eachView)
        }
    }
    
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
}
