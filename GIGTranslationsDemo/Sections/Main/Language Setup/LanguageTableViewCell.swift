//
//  LanguageTableViewCell.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LanguageTableViewCell"

    // MARK: - IBOutlets
    
    @IBOutlet weak var languageKeyLabel: UILabel!
    
    // MARK: - Public methods
    
    func setup(languageKey: String) {
        self.languageKeyLabel.text = languageKey
    }
}
