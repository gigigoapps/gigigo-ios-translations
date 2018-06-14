//
//  TranslationsController.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class TranslationsController {

    // MARK: - Singleton
    
    static let shared = TranslationsController()
    
    // MARK: - Private properties
    
    private var translationsDataManager: TranslationsDataManager?
    
    // MARK: - Public methods
    
    func setup(configurationURL: URL, bundle: Bundle, completion: ((Bool) -> Void)?) {
        let translationsDataManager = TranslationsDataManager(
            memory: Session(),
            disk: UserDefaultsManager(
                userDefaults: UserDefaults.standard
            ),
            local: FileSystemManager(
                bundle: bundle
            )
        )
        self.translationsDataManager = translationsDataManager
        let configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            translationsDataManager: translationsDataManager
        )
        configurationInteractor.configure(with: configurationURL) { success in
            completion?(success)
            self.syncTranslations()
        }
    }
    
    func languages() -> [String] {
        guard let translationsDataManager = self.translationsDataManager else {
            return []
        }
        let configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            translationsDataManager: translationsDataManager
        )
        return configurationInteractor.languages()
    }
    
    func set(language: String, completion: ((Bool) -> Void)?) {
        guard let translationsDataManager = self.translationsDataManager else {
            completion?(false)
            return
        }
        let translationsInteractor = TranslationsInteractor(
            translationsService: TranslationsService(),
            translationsDataManager: translationsDataManager
        )
        translationsInteractor.set(language: language, completion: completion)
    }
    
    func value(for key: String) -> String {
        guard let translationsDataManager = self.translationsDataManager else {
            return key
        }
        return translationsDataManager.translation(for: key)
    }
    
    func translations() -> [String: String] {
        guard
            let translationsDataManager = self.translationsDataManager,
            let language = translationsDataManager.loadLanguage(),
            let translations = translationsDataManager.loadTranslations(for: language)
        else {
            return [:]
        }
        return translations.translations
    }
    
    // MARK: - Private helpers
    
    private func syncTranslations() {
        guard let translationsDataManager = self.translationsDataManager else { return }
        let translationsInteractor = TranslationsInteractor(
            translationsService: TranslationsService(),
            translationsDataManager: translationsDataManager
        )
        translationsInteractor.syncTranslations()
    }
}
