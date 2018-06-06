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
    
    let languages: [String: URL?]
}
