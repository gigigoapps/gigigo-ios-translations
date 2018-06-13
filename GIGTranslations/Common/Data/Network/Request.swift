//
//  Request.swift
//  GIGTranslations
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

private enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
}

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
    
    func body<T: Decodable>(toType: T.Type) -> T? {
        guard let data = self.data else { return nil }
        let object = try? JSONDecoder().decode(T.self, from: data)
        return object
    }
    
    func headers() -> [AnyHashable: Any]? {
        guard let response = self.response else { return nil }
        return response.allHeaderFields
    }
}

class Request {
    
    // MARK: - Public methods
    
    static func get(_ url: URL, completion: @escaping (Result<Response, Error>) -> Void) {
        _request(url, method: .get) { data, response, error in
            guard let data = data else {
                completion(.error(error ?? NSError.unexpected()))
                return
            }
            completion(.success(Response(data: data, response: response as? HTTPURLResponse, error: error)))
        }
    }
    
    static func get<T: Decodable>(_ url: URL, toType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        _request(url, method: .get) { data, _, error in
            guard let data = data else {
                completion(.error(error ?? NSError.unexpected()))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch let error {
                completion(.error(error))
            }
        }
    }
    
    static func head(_ url: URL, completion: @escaping (Result<[AnyHashable: Any]?, Error>) -> Void) {
        _request(url, method: .head) { data, response, error in
            guard let data = data else {
                completion(.error(error ?? NSError.unexpected()))
                return
            }
            let response = Response(data: data, response: response as? HTTPURLResponse, error: error)
            completion(.success(response.headers()))
        }
    }
}

private extension Request {
    
    static func _request(_ url: URL, method: HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(
            configuration: sessionConfiguration,
            delegate: nil,
            delegateQueue: nil
        )
        session.dataTask(with: request, completionHandler: completion).resume()
    }
}
