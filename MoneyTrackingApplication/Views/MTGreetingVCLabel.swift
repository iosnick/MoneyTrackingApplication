//
//  MTGreetingVCLabel.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTGreetingVCLabel: UILabel {

    // MARK: - View Life Cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setLabelProperties(textColor: UIColor,
                            text: String,
                            textAlignment: NSTextAlignment = .center,
                            font: UIFont,
                            numberOfLines: Int = 1) {
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
