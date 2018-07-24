//
//  App.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

enum Platform {
    
    case iOS
    case android
    case universal
    
    func fileExtension() -> String {
        switch self {
        case .iOS:
            return "strings"
        case .android:
            return "xml"
        case .universal:
            return "json"
        }
    }
}

struct AppConfiguration {
    let configurationURL: String?
    let generateiOSFile: Bool
    let platform: Platform
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

            >> translations-sync [configuration-url] [--iOS|--android|--universal] [--ios-strings-file]
            
            - configuration-url: the configuration url (i.e. http://....index.json)
            --universal: (default) download the translations files in 'json' format
            --iOS: download the translations files in 'strings' format
            --android: download the translations files in 'xml' format
            --ios-strings-file: if you want to create a swift file with a constant for each translation
            
            """,
            minArgs: 1,
            maxArgs: 4
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
        self.downloadManager = DownloadManager(indexURL: indexURL, platform: configuration.platform)
        try self.downloadManager?.downloadAll {
            if configuration.generateiOSFile {
                try StringsGenerator(indexURL: indexURL).generate {
                    exit(0)
                }
            } else {
                exit(0)
            }
        }
    }
    
    private func configuration(from args: [String]?) -> AppConfiguration {
        guard let args = args else { return AppConfiguration(configurationURL: nil, generateiOSFile: false, platform: .universal) }
        let configURL = args.first(where: { $0.isLink() })
        let generateiOSFile = args.first(where: { $0.lowercased() == "--ios-strings-file" }) != nil
        let iOSPlatform = args.first(where: { $0.lowercased() == "--ios" }) != nil
        let androidPlatform = args.first(where: { $0.lowercased() == "--android" }) != nil
        let platform: Platform = {
            if iOSPlatform {
                return Platform.iOS
            } else if androidPlatform {
                return Platform.android
            }
            return Platform.universal
        }()
        return AppConfiguration(
            configurationURL: configURL,
            generateiOSFile: generateiOSFile,
            platform: platform
        )
    }
}

private extension Bool {
    
    static func ?? (lhs: Bool, rhs: Bool) -> Bool {
        return lhs ? lhs : rhs
    }
}
