//
//  MTCustomLabel.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTCustomLabel: UILabel {
    // MARK: - View Life Cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setLabelProperties(textColor: UIColor,
                            text: String,
                            textAlignment: NSTextAlignment = .center,
                            font: UIFont,
                            lines: Int = 1) {
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.numberOfLines = lines
    }
}
