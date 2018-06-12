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
        let configurationInteractor = ConfigurationInteractor()
        //configurationInteractor.configure()
        completion?(true)
    }
    
    func languages() -> [String] {
        let configurationInteractor = ConfigurationInteractor()
        return ["EN", "ES", "FR"]
    }
    
    func set(language: String, completion: ((Bool) -> Void)?) {
        let configurationInteractor = ConfigurationInteractor()
        // !!!
        completion?(true)
    }
    
    func value(for key: String) -> String? {
        // !!!
        return "Value"
    }
    
    func translations() -> [String: String] {
        return ["": ""]
    }
}
