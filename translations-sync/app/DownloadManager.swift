//
//  DownloadManager.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

private struct TranslationsResponse {
    let translations: [String: String]
    let lastModified: Date?
}

class DownloadManager {
    
    let indexURL: URL
    private let configurationService = ConfigurationService()
    private let translationsService = TranslationsService()
    private var languages: [String] = []
    private let configurationFile = ConfigurationFile()
    
    init(indexURL: URL) {
        self.indexURL = indexURL
    }
    
    // MARK: - Public methods
    
    func downloadAll(_ completion: () -> Void) throws {
        try self.downloadConfig { config in
            Log("The config file contains the following languages: \(String(describing: config.languages.keys))")
            self.languages = config.languages.keys.map({ $0 })
            try self.checkTranslationsAndDownload(of: 0, in: config)
        }
    }
    
    // MARK: - Private methods
    
    private func checkTranslationsAndDownload(of index: Int, in configuration: Configuration) throws {
        let language = self.languages[index]
        if TranslationFile(language: language).exist() {
            self.checkTranslationsFile(of: language, in: configuration) { newDate in
                if let newDate = newDate, let lastModified = self.configurationFile.lastModified(of: language) {
                    if !lastModified.isSameDate(that: newDate) {
                        try self.downloadTranslation(of: index, in: configuration)
                    } else {
                        Log("The language '\(language)' doesn't have changes")
                        try self.downloadNext(index, in: configuration)
                    }
                } else {
                    try self.downloadTranslation(of: index, in: configuration)
                }
            }
        } else {
            try self.downloadTranslation(of: index, in: configuration)
        }
    }
    
    private func downloadTranslation(of index: Int, in configuration: Configuration) throws {
        let language = self.languages[index]
        try self.downloadTranslations(of: language, in: configuration) { response in
            Log("Syncronized '\(language)'")
            let lastModified = response.lastModified ?? Date()
            try TranslationFile(language: language).set(contents: response.translations)
            try self.configurationFile.set(lastModifiedDate: lastModified, of: language)
            try self.downloadNext(index, in: configuration)
        }
    }
    
    private func downloadNext(_ index: Int, in configuration: Configuration) throws {
        if self.languages.count > index + 1 {
            try self.checkTranslationsAndDownload(of: index + 1, in: configuration)
        } else {
            Log("Sync process finished")
            exit(0)
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
    
    private func checkTranslationsFile(of language: String, in configuration: Configuration, completion: @escaping (Date?) throws -> Void) {
        self.translationsService.fetchTranslationsLastUpdateDate(of: language, in: configuration) { date in
            do {
                try completion(date)
            } catch let error {
                throw Abort(reason: error.localizedDescription)
            }
        }
    }
    
    private func downloadTranslations(of language: String, in configuration: Configuration, completion: @escaping (TranslationsResponse) throws -> Void) throws {
        self.translationsService.fetchTranslations(of: language, in: configuration) { result in
            switch result {
            case .success(let response):
                do {
                    let body = try response.body()
                    guard let translations = body as? [String: String] else {
                        throw Abort(reason: Strings.Errors.translationFileIsNotCorrect)
                    }
                    let lastModifiedString = response.headers()?["Last-Modified"] as? String
                    let date = Date(from: lastModifiedString ?? "", withFormat: "E, d MMM yyyy HH:mm:ss Z")
                    try completion(TranslationsResponse(translations: translations, lastModified: date))
                } catch let error {
                    throw Abort(reason: error.localizedDescription)
                }
            case .error(let error):
                throw Abort(reason: error.localizedDescription)
            }
        }
    }
}
