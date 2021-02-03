//
//  MTSignUpButton.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTSignUpButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        self.backgroundColor = UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    }
    
    func setButtonProperties(title: String, cornerRadius: CGFloat) {
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
