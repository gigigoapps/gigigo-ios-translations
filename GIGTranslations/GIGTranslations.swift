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
/// Use `GIGTranslations` singleton (i.e.: `GIGTranslations.shared`) to setup the framework for the integrating app
/// and retrieve translated copies.
///
/// ### Notes
/// Execute the `translations_sync` script and add the generated files to the integrating app to load default translations.
///
/// - Version: 1.0
/// - Authors: José Carlos Estela, Jerilyn Gonçalves
/// - Copyright: Gigigo S.L.
open class GIGTranslations: NSObject {
    
    /// Singleton instance
    ///
    /// - Since: 1.0
    public static let shared = GIGTranslations()
    
    // MARK: - Public methods
    
    /// Configures the framework to support translations for the integrating app.
    ///
    /// - Parameters:
    ///   - configurationURL: `URL` to the translations configuration file for the integrating app.
    ///   - bundle: `Bundle`for the integrating app, used for loading default translations.
    ///   - completion: Closure for handling the result of the setup operation. Returns: `true` on success, `false` otherwise.
    ///
    /// - Since: 1.0
    public func setup(configurationURL: URL, bundle: Bundle?, completion: ((Bool) -> Void)?) {
        TranslationsController.shared.setup(
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
    public func languages() -> [String] {
        return TranslationsController.shared.languages()
    }
    
    /// Configures the language for translations.
    ///
    /// - Parameters:
    ///   - language: `String` representation for language key.
    ///   - completion: Closure for handling the result of the set language operation. Returns: `true` on success, `false` otherwise.
    ///
    /// - Since: 1.0
    public func set(language: String, completion: ((Bool) -> Void)?) {
        TranslationsController.shared.set(
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
    public func value(for key: String) -> String {
        return TranslationsController.shared.value(for: key)
    }
    
    /// Retrieves available translations for the current configuration.
    ///
    /// - Returns: A dictionary where the key is the translation key, and the value is the translation value.
    ///
    /// - Since: 1.0
    public func translations() -> [String: String] {
        return TranslationsController.shared.translations()
    }
}
