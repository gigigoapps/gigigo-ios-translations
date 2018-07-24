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
        return self.memoryStore.loadConfiguration()?.languages.keys.map({ $0 }) ??
            self.diskStore.loadConfiguration()?.languages.keys.map({ $0 }) ??
            []
    }
    
    func loadConfiguration() -> ConfigurationModel? {
        return self.memoryStore.loadConfiguration() ?? self.diskStore.loadConfiguration()
    }
    
    func save(translations: TranslationsModel) {
        self.memoryStore.save(translations: translations)
        self.diskStore.save(translations: translations)
    }

    func loadTranslations(for language: String) -> TranslationsModel? {
        return self.memoryStore.loadTranslations(for: language) ??
            self.diskStore.loadTranslations(for: language) ??
            self.localLoader.loadTranslations(for: language)
    }
    
    func loadLanguage() -> String? {
        return self.memoryStore.loadLanguage() ??
            self.diskStore.loadLanguage()??
            self.localLoader.loadLanguage()
    }
    
    func translation(for key: String) -> String {
        return self.memoryStore.translation(for: key) ??
            self.diskStore.translation(for: key) ??
            self.localLoader.translation(for: key) ??
            NSLocalizedString(key, comment: "")
    }
}
