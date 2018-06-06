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
    
    private var argumentsValidator: ArgumentsValidator?
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
        self.argumentsValidator = ArgumentsValidator(args: args, helpMessage: "TBD...")
        try self.argumentsValidator?.validate()
        try self.start()
        RunLoop.main.run()
    }
    
    // MARK: - Private methods
    
    private func start() throws {
        let indexURL = try self.configurationFile.indexURL()
        self.downloadManager = DownloadManager(indexURL: indexURL)
        try self.downloadManager?.downloadAll() {
            exit(0)
        }
    }
}
