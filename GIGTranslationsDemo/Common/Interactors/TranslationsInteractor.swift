//
//  TranslationsInteractor.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import GIGTranslations

typealias TranslationsModel = (configuration: URL?, language: String?, translations: [String: String]?)

class TranslationsInteractor {
    
    var translationsModel: TranslationsModel = TranslationsModel(configuration: nil, language: nil, translations: nil)
    
    // MARK: - Public methods
    
    func configureTranslations(with url: String) {
        guard let URL = URL(string: url) else { return }
        TranslationsWrapper.shared.configure(with: URL) { (result) in
            if result {
                self.translationsModel.configuration = URL
            }
        }
    }
    
    func getLanguages() -> [String] {
        return TranslationsWrapper.shared.getLanguages()
    }
    func setLanguage(_ language: String) {
        guard !language.isEmpty else { return }
        TranslationsWrapper.shared.setLanguage(language) { (result) in
            if result {
                self.translationsModel.language = language
            }
        }
    }
    
    func getValue(for key: String) -> String? {
        guard !key.isEmpty else { return nil }
        return TranslationsWrapper.shared.value(for: key)
    }
}
