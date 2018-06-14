//
//  FileSystemManager.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 13/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class FileSystemManager: TranslationsLoader {
    
    // MARK: - Private attributes
    
    private let bundle: Bundle?
    // MARK: - Public methods
    
    init(bundle: Bundle?) {
        self.bundle = bundle
    }
    
    // MARK: - TranslationsLoader
    
    func loadTranslations(for language: String) -> Translations? {
        // !!!
        return nil
    }
    
    func translation(for key: String) -> String? {
        // !!!
        return nil
    }
    
    func loadLanguage() -> String? {
        return Locale.preferredLanguages.first
    }
}
