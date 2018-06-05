//
//  ConfigurationChecker.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

enum ConfigFileFields: String {
    case index
}

struct ConfigFile {
    
    // MARK: - Private attributes
    
    private let configJsonPath = pwd() + "/.config.json"
    
    // MARK: - Public methods
    
    func indexURL() throws -> URL {
        if !exist() {
            LogWarn(Strings.Warnings.configurationFileMissed)
            try create()
        }
        guard
            let contents = System.contents(atPath: self.configJsonPath),
            let configValues = try? JSONDecoder().decode([String: String].self, from: contents),
            let indexURL = configValues[ConfigFileFields.index.rawValue],
            let url = URL(string: indexURL)
        else {
            throw Abort(reason: Strings.Errors.configurationFileIsNotCorrect)
        }
        return url
    }
    
    // MARK: - Private methods
    
    private func exist() -> Bool {
        return System.exist(path: configJsonPath)
    }
    
    private func create() throws {
        LogInfo(Strings.Configuration.creatingFile)
        Log(Strings.Configuration.insertIndexURL)
        if let urlString = readLine(), let URL = URL(string: urlString) {
            let configFile = [ConfigFileFields.index.rawValue: URL.absoluteString]
            let configData = try JSONEncoder().encode(configFile)
            System.createFile(at: self.configJsonPath, contents: configData)
            LogInfo(Strings.Configuration.configFileCreated + " in " + self.configJsonPath)
        } else {
            throw Abort(reason: Strings.Errors.urlFormatIsNotCorrect)
        }
    }
    
}
