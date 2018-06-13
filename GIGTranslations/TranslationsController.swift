//
//  TranslationsController.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class TranslationsController {
    
    static let shared = TranslationsController()
    
    func setup(configurationURL: URL, bundle: Bundle?, completion: ((Bool) -> Void)?) {
        let configurationInteractor = ConfigurationInteractor(
            configurationService: ConfigurationService(),
            userDefaults: UserDefaultsManager(),
            session: Session.shared
        )
        configurationInteractor.configure(with: configurationURL, bundle: bundle) { success in
            completion?(success)
        }
    }
    
    func languages() -> [String] {
        //let configurationInteractor = ConfigurationInteractor()
        return ["EN", "ES", "FR"]
    }
    
    func set(language: String, completion: ((Bool) -> Void)?) {
        //let configurationInteractor = ConfigurationInteractor()
        // !!!
        completion?(true)
    }
    
    func value(for key: String) -> String? {
        // !!!
        return "Value"
    }
    
    func translations() -> [String: String] {
        return [
            "k1": "Value 1",
            "k2": "Value 2",
            "k3": "Value 3"
        ]
    }
}
