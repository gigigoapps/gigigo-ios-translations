//
//  TranslationsInteractor.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import GIGTranslations

protocol TranslationsInteractorInput {
    func configureTranslations(with url: String, completion: ((Bool) -> Void)?)
    func isConfigured() -> Bool
    func getLanguages() -> [String]
    func hasLanguage() -> Bool
    func setLanguage(_ language: String, completion: ((Bool) -> Void)?)
    func getValue(for key: String) -> String?
    func getTranslations() -> [String: String]
}


class TranslationsInteractor: TranslationsInteractorInput {
    
    var translationsModel: TranslationsModel = TranslationsModel.shared
    
    // MARK: - TranslationsInteractorInput
    
    func configureTranslations(with url: String, completion: ((Bool) -> Void)?) {
        guard let URL = URL(string: url) else { return }
        TranslationsWrapper.shared.configure(with: URL) { (result) in
            switch result {
            case .success:
                self.translationsModel.configuration = URL
                completion?(true)
            case .error:
                completion?(false)
            }
        }
    }
    
    func isConfigured() -> Bool {
        return self.translationsModel.configuration != nil
    }

    func getLanguages() -> [String] {
        return TranslationsWrapper.shared.getLanguages()
    }
    
    func setLanguage(_ language: String, completion: ((Bool) -> Void)?) {
        guard !language.isEmpty else { return }
        TranslationsWrapper.shared.setLanguage(language) { (result) in
            switch result {
            case .success:
                self.translationsModel.language = language
                completion?(true)
            case .error:
                completion?(false)
            }
        }
    }
    
    func hasLanguage() -> Bool {
        return self.translationsModel.language != nil
    }
    
    func getValue(for key: String) -> String? {
        guard !key.isEmpty else { return nil }
        return TranslationsWrapper.shared.value(for: key)
    }
    
    func getTranslations() -> [String: String] {
        return TranslationsWrapper.shared.getTranslations()
    }
}
