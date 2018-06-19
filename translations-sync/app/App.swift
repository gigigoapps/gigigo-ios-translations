//
//  App.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

struct AppConfiguration {
    let configurationURL: String?
    let generateiOSFile: Bool
}

class App {
    
    // MARK: - Private attributes
    
    private let configurationFile = ConfigurationFile()
    private var downloadManager: DownloadManager?
    
    // MARK: - Public methods
    
    init() {
        LogManager.shared.logLevel = .debug
    }
    
    /// Method for starting the app
    ///
    /// - Parameter args: arguments of app
    func run(args: [String]?) throws {
        log("Tranlations sync v1.0.0")
        let argumentsValidator = ArgumentsValidator(
            args: args,
            helpMessage: """
            ## Tranlations sync ##
            ##      Usage       ##

            >> translations-sync [configuration-url] [--ios-loc-file]
            
            - configuration-url: The configuration url (i.e. http://....index.json)
            --ios-strings-file: If you want to create a file with a constant for each translation
            
            """,
            minArgs: 1,
            maxArgs: 3
        )
        try argumentsValidator.validate()
        let configuration = self.configuration(from: args)
        if let configurationURLString = configuration.configurationURL, let indexURL = URL(string: configurationURLString) {
            try self.configurationFile.set(indexURL: indexURL)
        }
        try self.start(configuration)
        RunLoop.main.run()
    }
    
    // MARK: - Private methods
    
    private func start(_ configuration: AppConfiguration) throws {
        let indexURL = try self.configurationFile.indexURL()
        self.downloadManager = DownloadManager(indexURL: indexURL)
        try self.downloadManager?.downloadAll {
            if configuration.generateiOSFile {
                try StringsGenerator(indexURL: indexURL).generate() {
                    exit(0)
                }
            } else {
                exit(0)
            }
        }
    }
    
    private func configuration(from args: [String]?) -> AppConfiguration {
        guard let args = args else { return AppConfiguration(configurationURL: nil, generateiOSFile: false) }
        let configURL = args.first(where: { $0.isStringLink() })
        let ioLocFile = args.first(where: { $0.lowercased() == "--ios-loc-file" }) != nil
        return AppConfiguration(
            configurationURL: configURL,
            generateiOSFile: ioLocFile
        )
    }
}
