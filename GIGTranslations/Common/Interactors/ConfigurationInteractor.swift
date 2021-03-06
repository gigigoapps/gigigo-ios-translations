//
//  ConfigurationInteractor.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class ConfigurationInteractor {
    
    // MARK: - Public attributes
    
    let configurationService: ConfigurationServiceInput
    let translationsDataManager: TranslationsDataManager
    
    // MARK: - Initializer
    
    init(configurationService: ConfigurationServiceInput, translationsDataManager: TranslationsDataManager) {
        self.configurationService = configurationService
        self.translationsDataManager = translationsDataManager
    }
    
    // MARK: - Public methods

    func configure(with url: URL, completion: @escaping (TranslationsResult<TranslationsError>) -> Void) {
        self.configurationService.fetchConfig(of: url) { result in
            switch result {
            case .success(let configuration):
                self.translationsDataManager.save(configuration: configuration)
                completion(.success())
            case .error:
                completion(.error(.badConfigurationResponse))
            }
        }
    }
    
    func configuration() -> ConfigurationModel? {
        return self.translationsDataManager.loadConfiguration()
    }
    
    func languages() -> [String] {
        return self.translationsDataManager.languages()
    }
}
