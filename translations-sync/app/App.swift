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
    private let configFile = ConfigFile()
    
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
        let indexURL = try self.configFile.indexURL()
        Request.get(indexURL) { result in
            switch result {
            case .success(let data):
                print(String(data: data, encoding: .utf8))
            case .error(let error):
                print(error)
            }
        }
        // Now we have to download the configuration file
        // Then we have to download all jsons linked to the config file
    }
}
