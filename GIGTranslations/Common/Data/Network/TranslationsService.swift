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
    
    func fetchTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<TranslationsModel, Error>) -> Void) {
        guard let languageURL = configuration.languages[language], let URL = languageURL else {
            return completion(.error(NSError(domain: "The url for language \(language) is not correct", code: 0, userInfo: nil)))
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
                        completion(.error(RequestError.invalidResponseFormat))
                    }
            case .error(let error):
                completion(.error(error))
            }
        }
        //(URL, completion: )
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
