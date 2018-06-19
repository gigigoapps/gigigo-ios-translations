//
//  String+Extension.swift
//  localizable-constants-generator
//
//  Created by José Estela on 18/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension String {
    
    func underLinedToCamelCased() -> String {
        return self
            .split(separator: "_")
            .map({ $0.lowercased() })
            .map({ $0.capitalized })
            .joined()
            .enumerated()
            .map({ (offset, value) -> String in
                if offset == 0 {
                    return String(value).lowercased()
                }
                return String(value)
            })
            .joined()
    }
    
    func isLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
}
