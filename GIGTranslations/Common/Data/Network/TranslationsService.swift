//
//  TranslationsService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslationsServiceInput {
    func fetchTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<TranslationsModel, Error>) -> Void)
    func fetchTranslationsLastUpdateDate(of language: String, in configuration: ConfigurationModel, completion: @escaping (Date?) -> Void)
}

struct TranslationsService: TranslationsServiceInput {
    
    func fetchTranslationsResponse(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let languageURL = configuration.languages[language], let URL = languageURL else {
            return completion(.error(TranslationsError.invalidLanguageKey))
        }
        Request.get(URL) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func fetchTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<TranslationsModel, Error>) -> Void) {
        guard let languageURL = configuration.languages[language], let URL = languageURL else {
            return completion(.error(TranslationsError.invalidLanguageKey))
        }
        Request.get(URL) { (result) in
            switch result {
            case .success(let response):
                    if let body = try? response.body(),
                        let responseTranslations = body as? [String: String],
                        let lastModifiedString = response.headers()?["Last-Modified"] as? String,
                        let lastUpdateDate = Date(from: lastModifiedString, withFormat: "E, d MMM yyyy HH:mm:ss Z") {
                        let translations = TranslationsModel(language: language, lastUpdateDate: lastUpdateDate, translations: responseTranslations)
                        completion(.success(translations))
                    } else {
                        completion(.error(TranslationsError.languageSyncFailure))
                    }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func fetchTranslationsLastUpdateDate(of language: String, in configuration: ConfigurationModel, completion: @escaping (Date?) -> Void) {
        guard let languageURL = configuration.languages[language], let URL = languageURL else {
            return completion(nil)
        }
        Request.head(URL) { result in
            switch result {
            case .success(let headers):
                guard
                    let dateString = headers?["Last-Modified"] as? String,
                    let date = Date(from: dateString, withFormat: "E, d MMM yyyy HH:mm:ss Z")
                else {
                    return completion(nil)
                }
                completion(date)
            case .error:
                completion(nil)
            }
        }
    }
}
