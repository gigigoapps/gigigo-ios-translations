//
//  GIGTranslations.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

/// TODO - Add SDK's public class description
///
/// ### Usage
/// TODO - Add usage description
///
/// ### Overview
/// TODO - Add overview description
///
/// - Version: 1.0
/// - Copyright: Gigigo S.L.
open class GIGTranslations: NSObject {
    
    // MARK: - Public methods
    
    /// Add description
    ///
    /// - Parameters:
    ///   - configurationURL: Add description
    ///   - bundle: Add description
    public func setup(configurationURL: URL, bundle: Bundle?, completion: ((Bool) -> Void)?) {
        // !!!
        completion?(true)
    }
    
    /// Add description
    ///
    /// - Returns: Add description
    public func languages() -> [String] {
        // !!!
        return ["EN", "ES", "FR"]
    }
    
    /// Add description
    ///
    /// - Parameters:
    ///   - language: Add description
    ///   - completion: Add description
    public func set(language: String, completion: ((Bool) -> Void)?) {
        // !!!
        completion?(true)
    }
    
    /// Add description
    ///
    /// - Parameter key: Add description
    /// - Returns: Add description
    public func value(for key: String) -> String? {
        // !!!
        return "Value"
    }
    
    public func translations() -> [String: String] {
        // !!!
        return [
            "k1": "Value 1",
            "k2": "Value 2",
            "k3": "Value 3",
            "k4": "Value 4"
        ]
    }
}
