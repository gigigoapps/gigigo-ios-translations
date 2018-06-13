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
    let userDefaults: UserDefaultsManager
    let session: Session
    
    // MARK: - Initializer
    
    init(translationsService: TranslationsServiceInput, userDefaults: UserDefaultsManager, session: Session) {
        self.translationsService = translationsService
        self.userDefaults = userDefaults
        self.session = session
    }
    
    // MARK: - Public methods
    
    func get(language: String, completion: ((Bool) -> Void)?) {
        guard let configuration = session.loadConfiguration() else {
            completion?(false)
            return
        }
        self.translationsService.fetchTranslationsLastUpdateDate(of: language, in: configuration) { (lastUpdateDate) in
            if let translations = UserDefaultsManager.currentTranslations(for: language) {
                if translations.lastUpdateDate != lastUpdateDate {
                    // Fetch language
                    self.translationsService.fetchTranslations(of: language, in: configuration, completion: { (result) in
                        //case .success(let response):
                        //case .error(let error):
                    
                    })
                } else {
                    // Do nothing
                }
            } else {
                // Fetch language
            }
        }
    }
}
