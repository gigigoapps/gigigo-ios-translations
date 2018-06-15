//
//  Translations+Mock.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 15/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
@testable import GIGTranslations

extension Translations {
    
    static func mock(
        language: String = "\(Date().timeIntervalSince1970)",
        lastUpdateDate: Date = Date(),
        translations: [String: String] = [:]
    ) -> Translations {
        return Translations(language: language, lastUpdateDate: lastUpdateDate, translations: translations)
    }
}
