//
//  App.swift
//  localizable-constants-generator
//
//  Created by José Estela on 18/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct LocalizablesGenerator {
    
    private let configurationService = ConfigurationService()
    private let translationsService = TranslationsService()
    let indexURL: URL
    
    public func generate() throws {
        try self.downloadConfig { config in
            guard let first = config.languages.keys.first else { return }
            try self.downloadTranslations(of: first, in: config) { translations in
                let constants = translations.translations.keys.map { key in
                    "let kLocale\(key.underLineToCamelCase()) = translate(\"\(key)\")"
                }
                let fileValue = """
                /// Localizable.swift
                ///
                /// Auto-generated file (by localizable-constants-generator)
                ///
                
                import Foundation
                import GIGTranslations
                
                \(constants.joined(separator: "\n"))
                
                """
                System.createFile(at: System.current() + "/LocalizableConstants.swift", contents: fileValue.data(using: .utf8)!)
            }
        }
    }
    
    private func downloadConfig(_ completion: @escaping (Configuration) throws -> Void) throws {
        self.configurationService.fetchConfig(of: self.indexURL) { result in
            switch result {
            case .success(let configuration):
                do {
                    try completion(configuration)
                } catch let error {
                    throw Abort(reason: error.localizedDescription)
                }
            case .error:
                throw Abort(reason: Strings.Errors.configurationURLIsNotCorrect)
            }
        }
    }
    
    private func downloadTranslations(of language: String, in configuration: Configuration, completion: @escaping (TranslationsModel) throws -> Void) throws {
        self.translationsService.fetchTranslations(of: language, in: configuration) { result in
            switch result {
            case .success(let response):
                do {
                    try completion(response)
                } catch let error {
                    throw Abort(reason: error.localizedDescription)
                }
            case .error(let error):
                throw Abort(reason: error.localizedDescription)
            }
        }
    }
}
