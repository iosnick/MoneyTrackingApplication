//
//  MTCustomButton.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTCustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setButtonProperties(title: String,
                             cornerRadius: CGFloat = 0,
                             titleColor: UIColor,
                             backgroundColor: UIColor = .clear,
                             font: UIFont = UIFont.systemFont(ofSize: 19),
                             adjustsFontSizeToFitWidth: Bool = true) {
        self.titleLabel?.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
}

