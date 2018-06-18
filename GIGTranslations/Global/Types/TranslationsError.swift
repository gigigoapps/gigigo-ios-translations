//
//  TranslationsError.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 18/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

public enum TranslationsError: Error {
    
    case badConfigurationResponse
    case missingConfigurationSetup
    case invalidLanguageKey
    case languageSyncFailure
    
    public func description() -> String {
        switch self {
        case .badConfigurationResponse:
            return "Request for configuration failed"
        case .missingConfigurationSetup:
            return "Configuration setup is missing"
        case .invalidLanguageKey:
            return "Language key is invalid"
        case .languageSyncFailure:
            return "Language synchronization failed"
        }
    }
}
