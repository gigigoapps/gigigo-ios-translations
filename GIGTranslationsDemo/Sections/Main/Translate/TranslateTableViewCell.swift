//
//  TranslateTableViewCell.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class TranslateTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TranslateTableViewCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var translationKeyLabel: UILabel!
    @IBOutlet weak var translationValueLabel: UILabel!
    
    // MARK: - Public methods
    
    func setup(key: String, value: String) {
        self.translationKeyLabel.text = key
        self.translationValueLabel.text = value
    }
}
