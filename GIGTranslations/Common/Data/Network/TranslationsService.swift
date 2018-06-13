//
//  TranslationsService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslationsServiceInput {
    func fetchTranslations(of language: String, in configuration: Configuration, completion: @escaping (Result<Response, Error>) -> Void)
    func fetchTranslationsLastUpdateDate(of language: String, in configuration: Configuration, completion: @escaping (Date?) -> Void)
}

struct TranslationsService: TranslationsServiceInput {
    
    func fetchTranslations(of language: String, in configuration: Configuration, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let languageURL = configuration.languages[language], let URL = languageURL else {
            return completion(.error(NSError(domain: "The url for language \(language) is not correct", code: 0, userInfo: nil)))
        }
        Request.get(URL, completion: completion)
    }
    
    func fetchTranslationsLastUpdateDate(of language: String, in configuration: Configuration, completion: @escaping (Date?) -> Void) {
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
