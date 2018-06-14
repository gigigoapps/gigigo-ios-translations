//
//  UserDefaultsManager.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let translationsKeys = "GIGTranslationsKeys"
    static let translationsPrefix = "GIGTranslations"
    static let configuration = "GIGTranslationsConfiguration"
    static let language = "GIGTranslationsLanguage"
}

class UserDefaultsManager {
    
    // MARK: - Private attributes
    
    let userDefaults: UserDefaults
    
    // MARK: - Public methods
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    /// Remove stored translations for a given language on `UserDefaults`.
    ///
    /// - Parameter language: String` representation for the translations language.
    func resetTranslations(for language: String) {
        let key = UserDefaultsKeys.translationsPrefix + "_" + language
        self.userDefaults.removeObject(forKey: key)
    }
    
    /// Removes all stored translations on `UserDefaults`.
    func resetTranslations() {
        for key in self.storedLanguages() {
            self.userDefaults.removeObject(forKey: key)
        }
        self.userDefaults.removeObject(forKey: UserDefaultsKeys.translationsKeys)
    }
    
    // MARK: - Helpers
    
    fileprivate func storeLanguage(with key: String) {
        var storedLanguages = self.storedLanguages()
        if !storedLanguages.contains(key) {
            storedLanguages.append(key)
            if let encodedLanguages = try? PropertyListEncoder().encode(storedLanguages) {
                self.userDefaults.set(encodedLanguages, forKey: UserDefaultsKeys.translationsKeys)
            }
        }
    }
    
    fileprivate func storedLanguages() -> [String] {
        if let data = self.userDefaults.value(forKey: UserDefaultsKeys.translationsKeys) as? Data {
            if let values = try? PropertyListDecoder().decode([String].self, from: data) {
                return values
            }
        }
        return []
    }
}

extension UserDefaultsManager: TranslationsStore {
    
    func save(configuration: Configuration) {
        let encodedConfiguration = try? PropertyListEncoder().encode(configuration)
        self.userDefaults.set(encodedConfiguration, forKey: UserDefaultsKeys.configuration)
    }
    
    func loadConfiguration() -> Configuration? {
        guard let data = self.userDefaults.value(forKey: UserDefaultsKeys.configuration) as? Data else { return nil }
        return try? PropertyListDecoder().decode(Configuration.self, from: data)
    }
    
    func save(language: String) {
        self.userDefaults.set(language, forKey: UserDefaultsKeys.language)
    }
    
    func loadLanguage() -> String? {
        guard let language = self.userDefaults.value(forKey: UserDefaultsKeys.language) as? String else { return nil }
        return language
    }
    
    func save(translations: Translations) {
        guard !translations.language.isEmpty else { return }
        let key = UserDefaultsKeys.translationsPrefix + "_" + translations.language
        if let encodedTranslations = try? PropertyListEncoder().encode(translations) {
            // Store translations
            self.userDefaults.set(encodedTranslations, forKey: key)
            // Add key for language translations
            self.storeLanguage(with: key)
        }
        self.userDefaults.synchronize()
    }
    
    func loadTranslations(for language: String) -> Translations? {
        let key = UserDefaultsKeys.translationsPrefix + "_" + language
        if let data = self.userDefaults.value(forKey: key) as? Data {
            let value = try? PropertyListDecoder().decode(Translations.self, from: data)
            return value
        }
        return nil
    }
    
    func translation(for key: String) -> String? {
        if let language = self.loadLanguage(),
            let translations = self.loadTranslations(for: language) {
            return translations.translations[key]
        }
        return nil
    }
}
