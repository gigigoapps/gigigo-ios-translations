//
//  Configuration.swift
//  GIGTranslations
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct Configuration: Codable {
    
    // MARK: - Public attributes
    var path: URL
    var lastUpdateDate: Date
    var languages: [String: URL?]
}
