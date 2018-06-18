//
//  Result.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 18/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

enum Result<SuccessType, ErrorType> {
    case success(SuccessType)
    case error(ErrorType)
}

public enum TranslationsResult<TranslationsError> {
    case success()
    case error(TranslationsError)
}

