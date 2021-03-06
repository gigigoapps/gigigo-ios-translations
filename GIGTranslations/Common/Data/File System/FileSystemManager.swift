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
    
    private let bundle: Bundle
    private var language: String?
    
    // MARK: - Public methods
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    // MARK: - TranslationsLoader
    
    func loadTranslations(for language: String) -> TranslationsModel? {
        guard
            let path = self.bundle.path(forResource: language, ofType: "json"),
            let data = FileManager.default.contents(atPath: path),
            let translations = try? JSONDecoder().decode([String: String].self, from: data)
        else {
            let getLanguage = language.split(separator: "-")
            if getLanguage.count > 1 {
                let language = String(getLanguage[0])
                self.language = language
                return loadTranslations(for: language)
            }
            return nil
        }
        return TranslationsModel(language: language, lastUpdateDate: Date(), translations: translations)
    }
    
    func translation(for key: String) -> String? {
        guard let language = self.loadLanguage() else {
            return self.loadTranslations(for: "default")?.translations[key]
        }
        return self.loadTranslations(for: language)?.translations[key] ?? self.loadTranslations(for: "default")?.translations[key]
    }
    
    func loadLanguage() -> String? {
        return self.language ?? Locale.preferredLanguages.first
    }
    
    func save(language: String) {
        self.language = language
    }
}
