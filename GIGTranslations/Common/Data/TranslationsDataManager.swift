//
//  TranslationsDataManager.swift
//  GIGTranslations
//
//  Created by José Estela on 13/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslationsLoader {
    func save(language: String)
    func loadLanguage() -> String?
    func loadTranslations(for language: String) -> TranslationsModel?
    func translation(for key: String) -> String?
}

protocol TranslationsStore: TranslationsLoader {
    func save(configuration: ConfigurationModel)
    func loadConfiguration() -> ConfigurationModel?
    func save(translations: TranslationsModel)
}

class TranslationsDataManager {
    
    // MARK: - Private attributes
    
    private let memoryStore: TranslationsStore
    private let diskStore: TranslationsStore
    private let localLoader: TranslationsLoader
    
    // MARK: - Public methods
    
    init(memory: TranslationsStore, disk: TranslationsStore, local: TranslationsLoader) {
        self.memoryStore = memory
        self.diskStore = disk
        self.localLoader = local
    }
    
    func save(configuration: ConfigurationModel) {
        self.memoryStore.save(configuration: configuration)
        self.diskStore.save(configuration: configuration)
    }
    
    func save(language: String) {
        self.memoryStore.save(language: language)
        self.diskStore.save(language: language)
        self.localLoader.save(language: language)
    }
    
    func languages() -> [String] {
        let memoryLanguages = self.memoryStore.loadConfiguration()?.languages.keys.map({ $0 })
        let diskLanguages = self.diskStore.loadConfiguration()?.languages.keys.map({ $0 })
        return memoryLanguages ?? diskLanguages ?? []
    }
    
    func loadConfiguration() -> ConfigurationModel? {
        return self.memoryStore.loadConfiguration() ?? self.diskStore.loadConfiguration()
    }
    
    func save(translations: TranslationsModel) {
        self.memoryStore.save(translations: translations)
        self.diskStore.save(translations: translations)
    }

    func loadTranslations(for language: String) -> TranslationsModel? {
        let memoryTranslations = self.memoryStore.loadTranslations(for: language)
        let diskTranslations = self.diskStore.loadTranslations(for: language)
        let localTranlations = self.localLoader.loadTranslations(for: language)
        return memoryTranslations ?? diskTranslations ?? localTranlations
    }
    
    func loadLanguage() -> String? {
        let memoryLanguage = self.memoryStore.loadLanguage()
        let diskLanguage = self.diskStore.loadLanguage()
        let localLanguage = self.localLoader.loadLanguage()
        return memoryLanguage ?? diskLanguage ?? localLanguage
    }
    
    func translation(for key: String) -> String {
        let memoryTranslation = self.memoryStore.translation(for: key)
        let diskTranslation = self.diskStore.translation(for: key)
        let localTranslation = self.localLoader.translation(for: key)
        return memoryTranslation ?? diskTranslation ?? localTranslation ?? NSLocalizedString(key, comment: "")
    }
}
