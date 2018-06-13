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
    let userDefaults: UserDefaultsManager
    let session: Session
    
    // MARK: - Initializer
    
    init(configurationService: ConfigurationServiceInput, userDefaults: UserDefaultsManager, session: Session) {
        self.configurationService = configurationService
        self.userDefaults = userDefaults
        self.session = session
    }
    
    // MARK: - Public methods

    func configure(with url: URL, bundle: Bundle?, completion: @escaping (Bool) -> Void) {
        self.configurationService.fetchConfig(of: url) { result in
            switch result {
            case .success(let configuration):
                self.session.save(configuration: configuration)
                completion(true)
            case .error:
                completion(false)
            }
        }
    }
}
