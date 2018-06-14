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
            self.syncTranslations()
        }
    }
    
    func languages() -> [String] {
        guard let configurationInteractor = self.configurationInteractor else {
            return []
        }
        return configurationInteractor.languages()
    }
    
    func set(language: String, completion: ((Bool) -> Void)?) {
        self.setTranslationsInteractor()
        guard self.translationsInteractor != nil else {
            completion?(false)
            return
        }
        self.translationsInteractor?.set(language: language, completion: completion)
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
        self.setTranslationsInteractor()
        self.translationsInteractor?.syncTranslations()
    }
    
    private func setTranslationsInteractor() {
        if self.translationsInteractor == nil {
            guard let translationsDataManager = self.translationsDataManager else { return }
            self.translationsInteractor = TranslationsInteractor(
                translationsService: TranslationsService(),
                translationsDataManager: translationsDataManager
            )
        }
    }
}
