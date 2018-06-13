//
//  Translations.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 13/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct Translations: Codable {
    
    // MARK: - Public attributes
    
    var language: String
    var lastUpdateDate: Date
    var tanslations: [String: String]
}
