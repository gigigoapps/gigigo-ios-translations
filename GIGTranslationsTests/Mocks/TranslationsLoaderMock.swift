//
//  TranslationsLoaderMock.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 14/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
@testable import GIGTranslations

class TranslationsLoaderMock: TranslationsLoader {
    
    var translations: TranslationsModel?
    
    // MARK: - TranslationsLoader
    
    func save(language: String) {
        
    }
    
    func loadLanguage() -> String? {
        return nil
    }
    
    func loadTranslations(for language: String) -> TranslationsModel? {
        return self.translations
    }
    
    func translation(for key: String) -> String? {
        return self.translations?.translations[key]
    }
    
}
