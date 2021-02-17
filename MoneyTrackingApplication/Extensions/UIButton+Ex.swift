//
//  UIButton+Ex.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit

extension UIButton {
    func setupGradient(buttonCornerRadius: CGFloat,bounds: CGRect) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 68/255, green: 71/255, blue: 234/255, alpha: 1).cgColor,
                           UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1).cgColor]
        gradient.frame = bounds
        gradient.cornerRadius = buttonCornerRadius
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupBorderGradient(selfSize: CGSize, selfBounds: CGRect,borderWidth: CGFloat, buttonCornerRadius: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 68/255, green: 71/255, blue: 234/255, alpha: 1).cgColor,
                           UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1).cgColor]
        gradient.frame =  CGRect(origin: .zero, size: selfSize)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = buttonCornerRadius
        let shape = CAShapeLayer()
        shape.lineWidth = borderWidth 
        shape.path = UIBezierPath(roundedRect: selfBounds, cornerRadius: 22).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        self.layer.insertSublayer(gradient, at: 1)
    }
}
