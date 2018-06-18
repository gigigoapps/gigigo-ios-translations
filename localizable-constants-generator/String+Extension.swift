//
//  String+Extension.swift
//  localizable-constants-generator
//
//  Created by José Estela on 18/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension String {
    
    func underLineToCamelCase() -> String {
        return self.split(separator: "_").map({ $0.lowercased() }).map({ $0.capitalized }).joined()
    }
}
