//
//  TranslationsController.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class TranslationsController {
    
    static let shared = TranslationsController()
    
    private var translationsDataManager: TranslationsDataManager?
    
    private var configurationInteractor: ConfigurationInteractor?
    private var translationsInteractor: TranslationsInteractor?
    
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
        self.configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            translationsDataManager: translationsDataManager
        )
        self.configurationInteractor?.configure(with: configurationURL) { success in
            completion?(success)
        }
    }
    
    func languages() -> [String] {
        guard let configurationInteractor = self.configurationInteractor else {
            return []
        }
        return configurationInteractor.languages()
    }
    
    func set(language: String, completion: ((Bool) -> Void)?) {
        guard let translationsDataManager = self.translationsDataManager else {
            completion?(false)
            return
        }
        self.translationsInteractor = TranslationsInteractor(
            translationsService: TranslationsService(),
            translationsDataManager: translationsDataManager
        )
        translationsDataManager.save(language: language)
        self.translationsInteractor?.get(language: language, completion: completion)
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
}
