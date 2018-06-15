//
//  TranslationsWrapper.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import GIGTranslations

class TranslationsWrapper {
    
    public static let shared: TranslationsWrapper = TranslationsWrapper()
    
    // MARK: - Public methods
    
    func configure(with URL: URL, completion: ((Bool) -> Void)?) {
        GIGTranslations.setup(configurationURL: URL, bundle: Bundle.main, completion: completion)
    }
    
    func getLanguages() -> [String] {
        return GIGTranslations.languages()
    }
    
    func setLanguage(_ language: String, completion: ((Bool) -> Void)?) {
        GIGTranslations.set(language: language, completion: completion)
    }
    
    func value(for key: String) -> String? {
        return GIGTranslations.value(for: key)
    }
    
    func getTranslations() -> [String: String] {
        return GIGTranslations.translations()
    }
}
