//
//  TranslationsModel+Mock.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 15/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
@testable import GIGTranslations

extension TranslationsModel {
    
    static func mock(
        language: String = "\(Date().timeIntervalSince1970)",
        lastUpdateDate: Date = Date(),
        translations: [String: String] = [:]
    ) -> TranslationsModel {
        return TranslationsModel(language: language, lastUpdateDate: lastUpdateDate, translations: translations)
    }
}
