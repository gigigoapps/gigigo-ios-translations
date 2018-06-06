//
//  ConfigurationService+Extension.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension ConfigurationService {
    
    func fetchConfig(of url: URL, completion: @escaping (Result<Configuration, Error>) throws -> Void) {
        self.fetchConfig(of: url) { result in
            do {
                try completion(result)
            } catch let error {
               handleThrow(error)
            }
        }
    }
}
