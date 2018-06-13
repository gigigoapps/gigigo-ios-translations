//
//  ConfigurationService.swift
//  GIGTranslations
//
//  Created by Jerilyn Goncalves on 05/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol ConfigurationServiceInput {
    func fetchConfig(of url: URL, completion: @escaping (Result<Configuration, Error>) -> Void)
}

struct ConfigurationService: ConfigurationServiceInput {
    
    func fetchConfig(of url: URL, completion: @escaping (Result<Configuration, Error>) -> Void) {
        Request.get(url) { result in
            switch result {
            case .success(let response):
                guard let languages = response.body(toType: [String: String].self) else { return completion(.error(NSError.unexpected())) }
                let dateString = response.headers()?["Last-Modified"] as? String
                let date = Date(from: dateString, withFormat: "E, d MMM yyyy HH:mm:ss Z")
                let configuration = Configuration(
                    path: url,
                    lastUpdateDate: date ?? Date(),
                    languages: languages.mapValues({ URL(string: $0) })
                )
                completion(.success(configuration))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
