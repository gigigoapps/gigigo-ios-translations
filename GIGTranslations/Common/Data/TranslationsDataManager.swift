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
    
    private let memoryStorageLayer: TranslationsStore
    private let diskStorageLayer: TranslationsStore
    
    // MARK: - Public methods
    
    init(memory: TranslationsStore, disk: TranslationsStore) {
        self.memoryStorageLayer = memory
        self.diskStorageLayer = disk
    }
    
    func save(configuration: Configuration) {
        self.memoryStorageLayer.save(configuration: configuration)
        self.diskStorageLayer.save(configuration: configuration)
    }
    
    func save(language: String) {
        self.memoryStorageLayer.save(language: language)
        self.diskStorageLayer.save(language: language)
    }
    
    func languages() -> [String] {
        let memoryLanguages = self.memoryStorageLayer.loadConfiguration()?.languages.keys.map({ $0 })
        let diskLanguages = self.diskStorageLayer.loadConfiguration()?.languages.keys.map({ $0 })
        return (memoryLanguages ?? diskLanguages) ?? []
    }
    
    func loadConfiguration() -> Configuration? {
        return self.memoryStorageLayer.loadConfiguration() ?? self.diskStorageLayer.loadConfiguration()
    }
    
}
