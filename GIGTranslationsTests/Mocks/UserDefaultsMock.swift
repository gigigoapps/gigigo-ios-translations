//
//  UserDefaultsMock.swift
//  GIGTranslationsTests
//
//  Created by Jerilyn Goncalves on 15/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
@testable import GIGTranslations

class UserDefaultsMock: UserDefaultsProtocol {
    
    // MARK: - Public properties
    
    var stubDictionary: [String: Any]?
    
    // MARK: - Private properties

    fileprivate var userDefaultsDictionary = [String: Any]()
    
    // MARK: - Public Methods
    
    func removeObject(forKey key: String) {
        self.userDefaultsDictionary[key] = nil
    }
    
    func value(forKey key: String) -> Any? {
        return self.userDefaultsDictionary[key]
    }
    
    func set(_ value: Any?, forKey key: String) {
        self.userDefaultsDictionary[key] = value as AnyObject?
    }
}
