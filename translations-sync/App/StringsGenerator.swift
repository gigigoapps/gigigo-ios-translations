//
//  App.swift
//  localizable-constants-generator
//
//  Created by José Estela on 18/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct StringsGenerator {
    
    private let configurationService = ConfigurationService()
    private let translationsService = TranslationsService()
    let indexURL: URL
    
    public func generate(_ completion: @escaping () -> Void) throws {
        try self.downloadConfig { config in
            guard let first = config.languages.keys.first else { return }
            try self.downloadTranslations(of: first, in: config) { translations in
                let constants = translations.translations.keys.sorted().map { key in
                    "static let \(key.underLinedToCamelCased()) = translate(\"\(key)\")"
                }
                let fileValue = """
                /// Strings.swift
                ///
                /// Auto-generated file (by translations-sync)
                ///
                
                import Foundation
                import GIGTranslations
                
                struct Strings {
                
                \t\(constants.joined(separator: "\n\t"))
                
                }
                
                """
                let fileName = System.current() + "/Strings.swift"
                System.createFile(at: fileName, contents: fileValue.data(using: .utf8)!)
                logInfo("Strings file generated in: \(fileName)")
                completion()
            }
        }
    }
    
    private func downloadConfig(_ completion: @escaping (ConfigurationModel) throws -> Void) throws {
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
    
    private func downloadTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (TranslationsModel) throws -> Void) throws {
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
