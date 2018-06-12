//
//  ConfigurationChecker.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

enum ConfigurationFileFields: String {
    case index
}

class ConfigurationFile {
    
    // MARK: - Private attributes
    
    private let configJsonPath = pwd() + ".config.json"
    
    // MARK: - Public methods
    
    func indexURL() throws -> URL {
        if !exist() {
            logWarn(Strings.Warnings.configurationFileMissed)
            try create()
        }
        guard
            let contents = System.contents(atPath: self.configJsonPath),
            let configValues = try? JSONDecoder().decode([String: String].self, from: contents),
            let indexURL = configValues[ConfigurationFileFields.index.rawValue],
            let url = URL(string: indexURL)
        else {
            throw Abort(reason: Strings.Errors.configurationFileIsNotCorrect)
        }
        return url
    }
    
    func set(indexURL: URL) throws {
        if !exist() {
            LogWarn(Strings.Warnings.configurationFileMissed)
            try create()
        }
        guard
            let contents = System.contents(atPath: self.configJsonPath),
            var configValues = try? JSONDecoder().decode([String: String].self, from: contents)
        else {
            throw Abort(reason: Strings.Errors.configurationFileIsNotCorrect)
        }
        configValues[ConfigurationFileFields.index.rawValue] = indexURL.absoluteString
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let configData = try encoder.encode(configValues)
        System.createFile(at: self.configJsonPath, contents: configData)
    }
    
    func lastModified(of language: String) -> Date? {
        guard
            let contents = System.contents(atPath: self.configJsonPath),
            let configValues = try? JSONDecoder().decode([String: String].self, from: contents),
            let dateString = configValues[language],
            let date = Date(from: dateString, withFormat: "dd-MM-yyyy HH:mm:ss")
        else {
            return nil
        }
        return date
    }
    
    func set(lastModifiedDate date: Date, of language: String) throws {
        guard
            let contents = System.contents(atPath: self.configJsonPath),
            var configValues = try? JSONDecoder().decode([String: String].self, from: contents)
        else {
            throw Abort(reason: Strings.Errors.configurationFileIsNotCorrect)
        }
        configValues[language] = date.toString(withFormat: "dd-MM-yyyy HH:mm:ss")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let configData = try encoder.encode(configValues)
        System.createFile(at: self.configJsonPath, contents: configData)
    }
    
    // MARK: - Private methods
    
    private func exist() -> Bool {
        return System.exist(path: configJsonPath)
    }
    
    private func create() throws {
        logInfo(Strings.Configuration.creatingFile)
        log(Strings.Configuration.insertIndexURL)
        if let urlString = readLine(), let URL = URL(string: urlString) {
            let configFile = [ConfigurationFileFields.index.rawValue: URL.absoluteString]
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let configData = try encoder.encode(configFile)
            System.createFile(at: self.configJsonPath, contents: configData)
            logInfo(Strings.Configuration.configFileCreated + " in " + self.configJsonPath)
        } else {
            throw Abort(reason: Strings.Errors.urlFormatIsNotCorrect)
        }
    }
    
}
