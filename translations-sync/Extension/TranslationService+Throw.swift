//
//  TranslationService+Extension.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension TranslationsService {
    
    func fetchTranslationsResponse(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<Response, Error>) throws -> Void) {
        self.fetchTranslationsResponse(of: language, in: configuration) { result in
            do {
                try completion(result)
            } catch let error {
                handleThrow(error)
            }
        }
    }
    
    func fetchTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (Result<TranslationsModel, Error>) throws -> Void) {
        self.fetchTranslations(of: language, in: configuration) { result in
            do {
                try completion(result)
            } catch let error {
                handleThrow(error)
            }
        }
    }
    
    func fetchTranslationsLastUpdateDate(of language: String, in configuration: ConfigurationModel, completion: @escaping (Date?) throws -> Void) {
        self.fetchTranslationsLastUpdateDate(of: language, in: configuration) { date in
            do {
                try completion(date)
            } catch let error {
                handleThrow(error)
            }
        }
    }
}
