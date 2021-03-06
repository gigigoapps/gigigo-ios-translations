//
//  TranslationsInteractor.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class TranslationsInteractor {
    
    // MARK: - Public attributes
    
    let translationsService: TranslationsServiceInput
    let translationsDataManager: TranslationsDataManager
    
    // MARK: - Private properties
    
    lazy var fetchLanguagesGroup =  DispatchGroup()

    // MARK: - Initializer
    
    init(translationsService: TranslationsServiceInput, translationsDataManager: TranslationsDataManager) {
        self.translationsService = translationsService
        self.translationsDataManager = translationsDataManager
    }
    
    // MARK: - Public methods
    
    func set(language: String, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        guard let configuration = self.translationsDataManager.loadConfiguration() else {
            completion?(.error(.missingConfigurationSetup))
            return
        }
        self.translationsService.fetchTranslationsLastUpdateDate(of: language, in: configuration) { (lastUpdateDate) in
            if let translations = self.translationsDataManager.loadTranslations(for: language) {
                if translations.lastUpdateDate != lastUpdateDate {
                    self.fetchTranslations(for: language, in: configuration, completion: completion)
                } else {
                    completion?(.success())
                }
            } else {
                self.fetchTranslations(for: language, in: configuration, completion: completion)
            }
        }
    }
    
    func syncTranslations() {
        guard let configuration = self.translationsDataManager.loadConfiguration() else {
            return
        }
        for language in configuration.languages {
            self.fetchLanguagesGroup.enter()
            print("Will fetch translations for language: \(language)")
            self.fetchTranslations(for: language.key, in: configuration) { (result) in
                self.fetchLanguagesGroup.leave()
                switch result {
                case .success:
                    print("Fetch completed succesfully")
                case .error:
                    print("Fetch completed with failure")
                }
            }
        }
        self.fetchLanguagesGroup.notify(queue: DispatchQueue.main) {
            print("All translations synched")
        }
    }
    
    // MARK: - Private helpers
    
    func fetchTranslations(for language: String, in configuration: ConfigurationModel, completion: ((TranslationsResult<TranslationsError>) -> Void)?) {
        self.translationsService.fetchTranslations(of: language, in: configuration, completion: { (result) in
            switch result {
            case .success(let translations):
                self.translationsDataManager.save(translations: translations)
                completion?(.success())
            case .error:
                completion?(.error(.languageSyncFailure))
            }
        })
    }
}
