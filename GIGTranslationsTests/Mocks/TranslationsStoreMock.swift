//
//  TranslationsStoreMock.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 14/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
@testable import GIGTranslations

class TranslationsStoreMock: TranslationsStore {
    
    var translations: Translations?
    
    // MARK: - TranslationsStore
    
    func save(language: String) {
        
    }
    
    func loadLanguage() -> String? {
        return nil
    }
    
    func loadTranslations(for language: String) -> Translations? {
        return self.translations
    }
    
    func translation(for key: String) -> String? {
        return self.translations?.translations[key]
    }
    
    
    func save(configuration: Configuration) {
        
    }
    
    func loadConfiguration() -> Configuration? {
        return nil
    }
    
    func save(translations: Translations) {
        
    }
}
