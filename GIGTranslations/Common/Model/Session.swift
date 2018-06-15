//
//  Session.swift
//  GIGTranslations
//
//  Created by José Estela on 13/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class Session: TranslationsStore {
    
    // MARK: - Private attributes
    
    private var configuration: ConfigurationModel?
    private var language: String?
    private var translations: Set<TranslationsModel> = []

    // MARK: - Public methods
    
    func save(configuration: ConfigurationModel) {
        self.configuration = configuration
    }
    
    func loadConfiguration() -> ConfigurationModel? {
        return self.configuration
    }
    
    func save(translations: TranslationsModel) {
        self.translations.insert(translations)
    }
    
    func loadTranslations(for language: String) -> TranslationsModel? {
        return self.translations.first(where: { $0.language == language })
    }
    
    func translation(for key: String) -> String? {
        guard let language = self.language else { return nil }
        return self.loadTranslations(for: language)?.translations[key]
    }
    
    func save(language: String) {
        self.language = language
    }
    
    func loadLanguage() -> String? {
        return self.language
    }
}
