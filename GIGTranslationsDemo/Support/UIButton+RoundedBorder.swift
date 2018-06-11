//
//  UIButton+RoundedBorder.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupRoundedButton() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = self.isEnabled ? self.tintColor.cgColor : UIColor.lightGray.cgColor
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
