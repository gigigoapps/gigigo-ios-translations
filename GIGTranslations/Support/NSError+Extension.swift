//
//  NSError+Extension.swift
//  GIGTranslations
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension NSError {
    
    static func unexpected() -> NSError {
        return NSError(domain: "Unexpected error", code: 0, userInfo: nil)
    }
    
}
