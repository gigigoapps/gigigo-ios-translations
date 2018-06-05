//
//  Request.swift
//  GIGTranslations
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

enum Result<SuccessType, ErrorType> {
    case success(SuccessType)
    case error(ErrorType)
}

class Request {
    
    // MARK: - Public methods
    
    static func get(_
        url: URL,
        headers: [String: String]? = nil,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        _request(url, method: "GET") { data, responseData, error in
            guard let data = data else {
                completion(.error(error ?? NSError(domain: "Unexpected error", code: 0, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
    }
}

private extension Request {
    
    static func _request(_ url: URL, method: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: nil,
            delegateQueue: nil
        )
        session.dataTask(with: request, completionHandler: completion).resume()
    }
}
