//
//  MTSignInUpButton.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTSignInUpButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setButtonProperties(title: String,
                             cornerRadius: CGFloat = 0,
                             titleColor: UIColor,
                             backgroundColor: UIColor = .clear,
                             font: UIFont = UIFont.systemFont(ofSize: 19)) {
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
