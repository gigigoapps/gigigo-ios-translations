//
//  TranslationsModel.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation


class TranslationsModel {
    
    static let shared = TranslationsModel(configuration: nil, language: nil)
    var configuration: URL?
    var language: String?
    
    init(configuration: URL?, language: String?) {
        self.configuration = configuration
        self.language = language
    }
}
