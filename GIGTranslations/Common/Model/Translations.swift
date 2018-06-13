//
//  Translations.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 13/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct Translations: Codable, Hashable {
   
    // MARK: - Public attributes
    
    var language: String
    var lastUpdateDate: Date
    var tanslations: [String: String]
    
    var hashValue: Int {
        return self.language.hashValue
    }
}
