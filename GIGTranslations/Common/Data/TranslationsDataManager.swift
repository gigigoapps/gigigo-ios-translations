//
//  TranslationsDataManager.swift
//  GIGTranslations
//
//  Created by José Estela on 13/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslationsStore {
    func save(language: String)
    func save(configuration: Configuration)
    func loadConfiguration() -> Configuration?
    func save(translations: Translations)
    func loadTranslations(for language: String) -> Translations?
    func translation(for key: String) -> String?
}

class TranslationsDataManager {
    
    // MARK: - Private attributes
    
    private let memoryStore: TranslationsStore
    private let diskStore: TranslationsStore
    
    // MARK: - Public methods
    
    init(memory: TranslationsStore, disk: TranslationsStore) {
        self.memoryStore = memory
        self.diskStore = disk
    }
    
    func save(configuration: Configuration) {
        self.memoryStore.save(configuration: configuration)
        self.diskStore.save(configuration: configuration)
    }
    
    func save(language: String) {
        self.memoryStore.save(language: language)
        self.diskStore.save(language: language)
    }
    
    func languages() -> [String] {
        let memoryLanguages = self.memoryStore.loadConfiguration()?.languages.keys.map({ $0 })
        let diskLanguages = self.diskStore.loadConfiguration()?.languages.keys.map({ $0 })
        return (memoryLanguages ?? diskLanguages) ?? []
    }
    
    func loadConfiguration() -> Configuration? {
        return self.memoryStore.loadConfiguration() ?? self.diskStore.loadConfiguration()
    }
    
}
