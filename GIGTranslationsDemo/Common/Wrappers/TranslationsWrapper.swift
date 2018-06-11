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
    
    let translations: GIGTranslations = GIGTranslations()
    public static let shared: TranslationsWrapper = TranslationsWrapper()
    
    // MARK: - Public methods
    
    func configure(with URL: URL, completion: ((Bool) -> Void)?) {
        self.translations.setup(configurationURL: URL, bundle: Bundle.main, completion: completion)
    }
    
    func getLanguages() -> [String] {
        return self.translations.languages()
    }
    
    func setLanguage(_ language: String, completion: ((Bool) -> Void)?) {
        self.translations.set(language: language, completion: completion)
    }
    
    func value(for key: String) -> String? {
        return self.translations.value(for: key)
    }
    
    func getTranslations() -> [String: String] {
        return self.translations.translations()
    }
}
