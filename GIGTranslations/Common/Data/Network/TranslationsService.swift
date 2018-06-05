//
//  TranslationsService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslationsServiceInput {
    func get_(parameter: Any?, completion: @escaping (Error?) -> Void)
}

struct TranslationsService: TranslationsServiceInput {

    func get_(parameter: Any?, completion: @escaping (Error?) -> Void) {
        // TODO: !!!
    }
}
