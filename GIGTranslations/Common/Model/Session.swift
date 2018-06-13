//
//  Session.swift
//  GIGTranslations
//
//  Created by José Estela on 13/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

class Session {
    
    // MARK: - Public attributes
    
    static let shared = Session()
    
    // MARK: - Private attributes
    
    private var configuration: Configuration?
    private var bundle: Bundle?

    // MARK: - Public methods
    
    func save(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func loadBundle() -> Bundle? {
        return self.bundle
    }
    
    func save(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func loadConfiguration() -> Configuration? {
        return self.configuration
    }
}
