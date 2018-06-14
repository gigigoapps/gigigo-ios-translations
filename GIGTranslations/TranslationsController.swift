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
    
    func setup(configurationURL: URL, bundle: Bundle?, completion: ((Bool) -> Void)?) {
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
        self.translationsInteractor?.get(language: language, completion: completion)
        // TODO: Set language !!!
    }
    
    func value(for key: String) -> String {
        return "Value"
    }
    
    func translations() -> [String: String] {
        return [
            "k1": "Value 1",
            "k2": "Value 2",
            "k3": "Value 3"
        ]
    }
}
