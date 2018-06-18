//
//  UserDefaultsProtocol.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 15/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey key: String)
    func removeObject(forKey key: String)
}

extension UserDefaults: UserDefaultsProtocol {    
}
