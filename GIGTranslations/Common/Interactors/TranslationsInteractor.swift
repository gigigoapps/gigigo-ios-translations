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
    
    // MARK: - Initializer
    
    init(translationsService: TranslationsServiceInput, translationsDataManager: TranslationsDataManager) {
        self.translationsService = translationsService
        self.translationsDataManager = translationsDataManager
    }
    
    // MARK: - Public methods
    
    func get(language: String, completion: ((Bool) -> Void)?) {
        guard let configuration = self.translationsDataManager.loadConfiguration() else {
            completion?(false)
            return
        }
        self.translationsService.fetchTranslationsLastUpdateDate(of: language, in: configuration) { (lastUpdateDate) in
            if let translations = self.translationsDataManager.loadTranslations(for: language) {
                if translations.lastUpdateDate != lastUpdateDate {
                    self.fetchTranslations(for: language, in: configuration, completion: completion)
                } else {
                    completion?(false)
                }
            } else {
                self.fetchTranslations(for: language, in: configuration, completion: completion)
            }
        }
    }
    
    // MARK: - Private helpers
    
    func fetchTranslations(for language: String, in configuration: Configuration, completion: ((Bool) -> Void)?) {
        self.translationsService.fetchTranslations(of: language, in: configuration, completion: { (result) in
            switch result {
            case .success(let translations):
                self.translationsDataManager.save(translations: translations)
                completion?(true)
            case .error:
                completion?(false)
            }
        })
    }
}
