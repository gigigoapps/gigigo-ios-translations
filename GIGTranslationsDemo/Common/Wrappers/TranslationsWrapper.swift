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
    
    func configure() {
        Translations.setup(bundle: .main)
    }
    
    func configure(with URL: URL, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        Translations.setup(configurationURL: URL, bundle: Bundle.main, completion: completion)
    }
    
    func getLanguages() -> [String] {
        return Translations.languages()
    }
    
    func setLanguage(_ language: String, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        Translations.set(language: language, languageSyncCompletion: completion)
    }
    
    func value(for key: String) -> String? {
        return Translations.value(for: key)
    }
    
    func getTranslations() -> [String: String] {
        return Translations.translations()
    }
}
