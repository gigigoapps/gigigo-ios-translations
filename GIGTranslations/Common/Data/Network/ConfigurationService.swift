//
//  ConfigurationService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol ConfigurationServiceInput {
    // func fetchConfig(of url: URL, completion: @escaping (Result<Configuration, Error>) -> Void)
}

struct ConfigurationService: ConfigurationServiceInput {
    
    func fetchConfig(of url: URL, completion: @escaping (Result<Configuration, Error>) -> Void) {
        Request.get(url, toType: [String: String].self) { result in
            switch result {
            case .success(let languages):
                let configuration = Configuration(
                    path: url,
                    lastUpdateDate: Date(), // !!!
                    languages: languages.mapValues({ URL(string: $0) })
                )
                completion(.success(configuration))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
