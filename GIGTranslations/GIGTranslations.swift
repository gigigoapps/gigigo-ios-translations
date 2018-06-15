//
//  GIGTranslations.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

/// GIGTranslations framework
///
/// ### Overview
/// The `GIGTranslations` framework offers an interface to load translated copies for an app from `Gigigo Translation Center`
///
/// ### Usage
/// Use `GIGTranslations` class (i.e.: `GIGTranslations`) to setup the framework for the integrating app
/// and retrieve translated copies.
///
/// ### Notes
/// Execute the `translations_sync` script and add the generated files to the integrating app to load default translations.
///
/// - Version: 1.0
/// - Authors: José Carlos Estela, Jerilyn Gonçalves
/// - Copyright: Gigigo S.L.
open class GIGTranslations: NSObject {
    
    private static let translationsController = TranslationsController.shared
    
    // MARK: - Public methods
    
    /// Configures the framework to support translations for the integrating app.
    ///
    /// - Parameters:
    ///   - configurationURL: `URL` to the translations configuration file for the integrating app.
    ///   - completion: Closure for handling the result of the setup operation. Returns: `true` on success, `false` otherwise.
    ///
    /// - Since: 1.0
    public class func setup(configurationURL: URL, completion: ((Bool) -> Void)?) {
        self.translationsController.setup(
            configurationURL: configurationURL,
            bundle: Bundle.main,
            completion: completion
        )
    }
    
    /// Configures the framework to support translations for the integrating app.
    ///
    /// - Parameters:
    ///   - configurationURL: `URL` to the translations configuration file for the integrating app.
    ///   - bundle: `Bundle`for the integrating app, used for loading default translations.
    ///   - completion: Closure for handling the result of the setup operation. Returns: `true` on success, `false` otherwise.
    ///
    /// - Since: 1.0
    public class func setup(configurationURL: URL, bundle: Bundle, completion: ((Bool) -> Void)?) {
        self.translationsController.setup(
            configurationURL: configurationURL,
            bundle: bundle,
            completion: completion
        )
    }
    
    /// Retrieves available languages for the current configuration.
    ///
    /// - Returns: A collection with the keys for all available languages.
    ///
    /// - Since: 1.0
    public class func languages() -> [String] {
        return self.translationsController.languages()
    }
    
    /// Configures the language for translations.
    ///
    /// - Parameters:
    ///   - language: `String` representation for language key.
    ///   - completion: Closure for handling the result of the set language operation. Returns: `true` on success, `false` otherwise.
    ///
    /// - Since: 1.0
    public class func set(language: String, completion: ((Bool) -> Void)?) {
        self.translationsController.set(
            language: language,
            completion: completion
        )
    }
    
    /// Retrieves the translation value for a given key.
    ///
    /// - Parameter key: `String` representation for translation key.
    /// - Returns: Value for the requested key, translated to the configured language.
    ///
    /// - Since: 1.0
    public class func value(for key: String) -> String {
        return self.translationsController.value(for: key)
    }
    
    /// Retrieves available translations for the current configuration.
    ///
    /// - Returns: A dictionary where the key is the translation key, and the value is the translation value.
    ///
    /// - Since: 1.0
    public class func translations() -> [String: String] {
        return self.translationsController.translations()
    }
}

/// Retrieves the translation value for a given key.
///
/// - Parameter key: `String` representation for translation key.
/// - Returns: Value for the requested key, translated to the configured language.
///
/// - Since: 1.0
public func translate(_ key: String) -> String {
    return GIGTranslations.value(for: key)
}
