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
}

class UserDefaultsManager {
    
    /// Updates the translations for a given language on `UserDefaults`.
    ///
    /// - Parameters:
    ///   - translations: `Dictionary` with translations.
    ///   - language: `String` representation for the translations language.
    static func setTranslations(_ translations: [String: String], for language: String) {
        guard !language.isEmpty else { return }
        let key = UserDefaultsKeys.translationsPrefix + "_" + language
        let value = Translations(language: language, lastUpdateDate: Date(), tanslations: translations)
        if let encodedTranslations = try? PropertyListEncoder().encode(value) {
            // Store translations
            UserDefaults.standard.set(encodedTranslations, forKey: key)
            // Add key for language translations
            self.storeLanguage(with: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    /// Retrieves the stored translations for a given language on `UserDefaults`.
    ///
    /// - Parameter language: `String` representation for the translations language.
    /// - Returns: `Translations` instance with stored translations if available, `nil` otherwise.
    static func currentTranslations(for language: String) -> Translations? {
        let key = UserDefaultsKeys.translationsPrefix + "_" + language
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            let value = try? PropertyListDecoder().decode(Translations.self, from: data)
            return value
        }
        return nil
    }
    
    /// Remove stored translations for a given language on `UserDefaults`.
    ///
    /// - Parameter language: String` representation for the translations language.
    static func resetTranslations(for language: String) {
        let key = UserDefaultsKeys.translationsPrefix + "_" + language
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    /// Removes all stored translations on `UserDefaults`.
    static func resetTranslations() {
        for key in self.storedLanguages() {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.translationsKeys)
    }
    
    // MARK: - Helpers
    
    private static func storeLanguage(with key: String) {
        var storedLanguages = self.storedLanguages()
        if !storedLanguages.contains(key) {
            storedLanguages.append(key)
            if let encodedLanguages = try? PropertyListEncoder().encode(storedLanguages) {
                UserDefaults.standard.set(encodedLanguages, forKey: UserDefaultsKeys.translationsKeys)
            }
        }
    }
    
    private static func storedLanguages() -> [String] {
        if let data = UserDefaults.standard.value(forKey: UserDefaultsKeys.translationsKeys) as? Data {
            if let values = try? PropertyListDecoder().decode([String].self, from: data) {
                return values
            }
        }
        return []
    }
}
