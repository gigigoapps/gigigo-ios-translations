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
    
    func setup(bundle: Bundle) {
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
    }
    
    func set(configurationURL: URL, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        guard let translationsDataManager = self.translationsDataManager else {
            print("The SDK is not configured yet. Please, call setup(bundle:) method")
            completion?(.error(.missingConfigurationSetup))
            return
        }
        let configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            translationsDataManager: translationsDataManager
        )
        configurationInteractor.configure(with: configurationURL) { result in
            completion?(result)
            self.syncTranslations()
        }
    }
    
    func languages() -> [String] {
        guard let translationsDataManager = self.translationsDataManager else {
            print("The SDK is not configured yet. Please, call setup(bundle:) method")
            return []
        }
        let configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            translationsDataManager: translationsDataManager
        )
        return configurationInteractor.languages()
    }
    
    func set(language: String, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        guard let translationsDataManager = self.translationsDataManager else {
            print("The SDK is not configured yet. Please, call setup(bundle:) method")
            completion?(.error(.missingConfigurationSetup))
            return
        }
        let translationsInteractor = TranslationsInteractor(
            translationsService: TranslationsService(),
            translationsDataManager: translationsDataManager
        )
        translationsDataManager.save(language: language)
        translationsInteractor.set(language: language, completion: completion)
    }
    
    func value(for key: String) -> String {
        guard let translationsDataManager = self.translationsDataManager else {
            print("The SDK is not configured yet. Please, call setup(bundle:) method")
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
