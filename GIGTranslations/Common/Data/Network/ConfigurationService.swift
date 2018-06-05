//
//  ConfigurationService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol ConfigurationServiceInput {
    func get_(parameter: Any?, completion: @escaping (Error?) -> Void)
}

struct ConfigurationService: ConfigurationServiceInput {
    
    func get_(parameter: Any?, completion: @escaping (Error?) -> Void) {
        // TODO: !!!
    }
}
