//
//  DownloadManager.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class DownloadManager {
    
    // MARK: - Public attributes
    
    let indexURL: URL
    
    // MARK: - Private attributes
    
    private let configurationService = ConfigurationService()
    private let translationsService = TranslationsService()
    private var languages: [String] = []
    private let configurationFile = ConfigurationFile()
    
    // MARK: - Public methods
    
    /// Setup with the coonfiguration index URL
    ///
    /// - Parameter indexURL: The index URL
    init(indexURL: URL) {
        self.indexURL = indexURL
    }
    
    /// Start the download process of all information (config file + all translation files)
    ///
    /// - Parameter completion: when the process did finish
    /// - Throws: if any error occurs
    func downloadAll(_ completion: () -> Void) throws {
        try self.downloadConfig { config in
            log("The config file contains the following languages: \(String(describing: config.languages.keys))")
            self.languages = config.languages.keys.map({ $0 })
            self.removeDeletedLanguages()
            try self.checkTranslationsAndDownload(of: 0, in: config)
        }
    }
    
    // MARK: - Private methods
    
    private func removeDeletedLanguages() {
        let setOfLanguages = Set(self.languages)
        var setOfCurrentLanguages = Set(self.currentLanguageFiles())
        setOfCurrentLanguages.subtract(setOfLanguages)
        setOfCurrentLanguages.forEach {
            System.removeItem(at: pwd() + $0 + ".json")
            logWarn("Removing '\($0)'")
        }
    }
    
    private func checkTranslationsAndDownload(of index: Int, in configuration: ConfigurationModel) throws {
        let language = self.languages[index]
        if TranslationsFile(language: language).exist() {
            self.checkTranslationsFile(of: language, in: configuration) { newDate in
                if let newDate = newDate, let lastModified = self.configurationFile.lastModified(of: language) {
                    if !lastModified.isSameDate(that: newDate) {
                        log("Updating '\(language)'")
                        try self.downloadTranslation(of: index, in: configuration)
                    } else {
                        log("The language '\(language)' doesn't have changes")
                        try self.downloadNext(index, in: configuration)
                    }
                } else {
                    log("Updating '\(language)'")
                    try self.downloadTranslation(of: index, in: configuration)
                }
            }
        } else {
            log("Downloading '\(language)'")
            try self.downloadTranslation(of: index, in: configuration)
        }
    }
    
    private func downloadTranslation(of index: Int, in configuration: ConfigurationModel) throws {
        let language = self.languages[index]
        try self.downloadTranslations(of: language, in: configuration) { response in
            let lastModified = response.lastUpdateDate
            try TranslationsFile(language: language).set(contents: response.translations)
            try self.configurationFile.set(lastModifiedDate: lastModified, of: language)
            try self.downloadNext(index, in: configuration)
        }
    }
    
    private func downloadNext(_ index: Int, in configuration: ConfigurationModel) throws {
        if self.languages.count > index + 1 {
            try self.checkTranslationsAndDownload(of: index + 1, in: configuration)
        } else {
            log("Sync process finished")
            exit(0)
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
    
    private func checkTranslationsFile(of language: String, in configuration: ConfigurationModel, completion: @escaping (Date?) throws -> Void) {
        self.translationsService.fetchTranslationsLastUpdateDate(of: language, in: configuration) { date in
            do {
                try completion(date)
            } catch let error {
                throw Abort(reason: error.localizedDescription)
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
    
    private func currentLanguageFiles() -> [String] {
        return System.listItems(in: pwd())?
            .filter { $0.contains(".json") && $0 != ".config.json" }
            .map { $0.replacingOccurrences(of: ".json", with: "") } ?? []
    }
}
