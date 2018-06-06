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

class Response {
    
    // MARK: - Public attributes
    
    let data: Data?
    let response: HTTPURLResponse?
    let error: Error?
    
    // MARK: - Public methods
    
    init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func body() throws -> [AnyHashable: Any]? {
        guard let data = self.data else { throw self.error ?? NSError(domain: "The response doesn't contain a body", code: 0, userInfo: nil) }
        return try JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any]
    }
    
    func headers() -> [AnyHashable: Any]? {
        guard let response = self.response else { return nil }
        return response.allHeaderFields
    }
}

class Request {
    
    // MARK: - Public methods
    
    static func get(_
        url: URL,
        headers: [String: String]? = nil,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        _request(url, method: "GET") { data, response, error in
            guard let data = data else {
                completion(.error(error ?? NSError(domain: "Unexpected error", code: 0, userInfo: nil)))
                return
            }
            completion(.success(Response(data: data, response: response as? HTTPURLResponse, error: error)))
        }
    }
    
    static func head(_
        url: URL,
        headers: [String: String]? = nil,
        completion: @escaping (Result<[AnyHashable: Any]?, Error>) -> Void
    ) {
        _request(url, method: "HEAD") { data, response, error in
            guard let data = data else {
                completion(.error(error ?? NSError(domain: "Unexpected error", code: 0, userInfo: nil)))
                return
            }
            let response = Response(data: data, response: response as? HTTPURLResponse, error: error)
            completion(.success(response.headers()))
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
