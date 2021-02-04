//
//  MTGreetingVCImageView.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 03.02.2021.
//

import UIKit

class MTGreetingVCImageView: UIImageView {
    
    // MARK: - View Life Cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setImage(named: String) {
        self.image = UIImage(named: named)
    }
}
