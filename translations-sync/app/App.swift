//
//  App.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

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
        Log("Tranlations sync v1.0.0")
        let argumentsValidator = ArgumentsValidator(args: args, helpMessage: "Usage:\ntranslations-sync [-u|--update-config]", minArgs: 1, maxArgs: 2)
        try argumentsValidator.validate()
        let indexURLArgument = argumentsValidator.arguments(for: 1).first
        if let indexURLArgument = indexURLArgument, let indexURL = URL(string: indexURLArgument) {
            try self.configurationFile.set(indexURL: indexURL)
        }
        try self.start()
        RunLoop.main.run()
    }
    
    // MARK: - Private methods
    
    private func start() throws {
        let indexURL = try self.configurationFile.indexURL()
        self.downloadManager = DownloadManager(indexURL: indexURL)
        try self.downloadManager?.downloadAll {
            exit(0)
        }
    }
}
