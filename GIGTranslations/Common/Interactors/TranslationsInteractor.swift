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
                    // Fetch language
                    self.translationsService.fetchTranslations(of: language, in: configuration, completion: { (result) in
                        switch result {
                        case .success(let response):
                            if let body = try? response.body(),
                                let responseTranslations = body as? [String: String],
                                let lastModifiedString = response.headers()?["Last-Modified"] as? String,
                                let lastUpdateDate = Date(from: lastModifiedString, withFormat: "E, d MMM yyyy HH:mm:ss Z") {
                
                                let translations = Translations(language: language, lastUpdateDate: lastUpdateDate, tanslations: responseTranslations)
                                self.translationsDataManager.save(translations: translations)
                                completion?(true)
                            } else {
                                completion?(false)
                            }
                        case .error(let error):
                            print(error.localizedDescription)
                            completion?(false)
                        }
                    })
                } else {
                    // Do nothing
                }
            } else {
                // Fetch language
            }
        }
    }
    
    // MARK: - Private helpers
    
    func fetchTranslations(for language: String, completion: ((Bool) -> Void)?) {
        
    }
}
