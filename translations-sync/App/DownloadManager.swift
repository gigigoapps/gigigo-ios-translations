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
    let platform: Platform
    
    // MARK: - Private attributes
    
    private let configurationService = ConfigurationService()
    private let translationsService = TranslationsService()
    private var languages: [String] = []
    private let configurationFile = ConfigurationFile()
    private var downloadCompletionBlock: (() throws -> Void)?
    
    // MARK: - Public methods
    
    /// Setup with the coonfiguration index URL
    ///
    /// - Parameter indexURL: The index URL
    init(indexURL: URL, platform: Platform) {
        self.indexURL = indexURL
        self.platform = platform
    }
    
    /// Start the download process of all information (config file + all translation files)
    ///
    /// - Parameter completion: when the process did finish
    /// - Throws: if any error occurs
    func downloadAll(_ completion: @escaping () throws -> Void) throws {
        self.downloadCompletionBlock = completion
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
            System.removeItem(at: pwd() + $0 + Constants.JSONFileExtension)
            logWarn("Removing '\($0)'")
        }
    }
    
    private func checkTranslationsAndDownload(of index: Int, in configuration: ConfigurationModel) throws {
        let language = self.languages[index]
        if TranslationsFile(language: language, platform: self.platform).exist() {
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
            try TranslationsFile(language: language, platform: self.platform).set(content: response.data)
            try self.configurationFile.set(lastModifiedDate: lastModified, of: language)
            try self.downloadNext(index, in: configuration)
        }
    }
    
    private func downloadNext(_ index: Int, in configuration: ConfigurationModel) throws {
        if self.languages.count > index + 1 {
            try self.checkTranslationsAndDownload(of: index + 1, in: configuration)
        } else {
            log("Sync process finished")
            try self.downloadCompletionBlock?()
        }
    }
    
    private func downloadConfig(_ completion: @escaping (ConfigurationModel) throws -> Void) throws {
        self.configurationService.fetchConfig(of: self.indexURL) { result in
            switch result {
            case .success(let configuration):
                do {
                    try completion(configuration)
                } catch let error {
                    handleThrow(error)
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
                handleThrow(error)
            }
        }
    }
    
    private func downloadTranslations(of language: String, in configuration: ConfigurationModel, completion: @escaping (TranslationsResponse) throws -> Void) throws {
        
        guard
            let languageURL = configuration.languages[language],
            let URL = languageURL,
            URL.lastPathComponent.contains(self.platform.fileExtension())
        else {
            throw Abort(reason: "Translations for '--\(self.platform)' should be '.\(self.platform.fileExtension())' files")
        }
        
        self.translationsService.fetchTranslationsResponse(of: language, in: configuration) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    throw Abort(reason: "Translations for \(language) are in invalid format")
                }
                let date: Date = {
                    if  let lastModifiedString = response.headers()?["Last-Modified"] as? String,
                        let lastUpdateDate = Date(from: lastModifiedString, withFormat: "E, d MMM yyyy HH:mm:ss Z") {
                        return lastUpdateDate
                    }
                    return Date()
                }()
                do {
                    try completion(TranslationsResponse(data: data, lastUpdateDate: date))
                } catch let error {
                    handleThrow(error)
                }
            case .error(let error):
                throw Abort(reason: error.localizedDescription)
            }
        }
    }
    
    private func currentLanguageFiles() -> [String] {
        return System.listItems(in: pwd())?
            .filter { $0.contains(Constants.JSONFileExtension) && $0 != Constants.configFilename }
            .map { $0.replacingOccurrences(of: Constants.JSONFileExtension, with: "") } ?? []
    }
}
