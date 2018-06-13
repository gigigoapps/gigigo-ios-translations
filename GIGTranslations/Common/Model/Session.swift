//
//  Session.swift
//  GIGTranslations
//
//  Created by José Estela on 13/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class Session: TranslationsStore {
    
    // MARK: - Public attributes
    
    static let shared = Session()
    
    // MARK: - Private attributes
    
    private var configuration: Configuration?
    private var language: String?
    private var translations: Set<Translations> = []
    private var bundle: Bundle?

    // MARK: - Public methods
    
    func save(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func loadBundle() -> Bundle? {
        return self.bundle
    }
    
    func save(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func loadConfiguration() -> Configuration? {
        return self.configuration
    }
    
    func save(translations: Translations) {
        self.translations.insert(translations)
    }
    
    func loadTranslations(for language: String) -> Translations? {
        return self.translations.first(where: { $0.language == language })
    }
    
    func translation(for key: String) -> String? {
        guard let language = self.language else { return nil }
        return self.loadTranslations(for: language)?.tanslations[key]
    }
    
    func save(language: String) {
        self.language = language
    }
}
