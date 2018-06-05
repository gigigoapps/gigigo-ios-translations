//
//  Arguments.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

struct ArgumentsValidator {
    
    // MARK: - Public attributes
    
    let args: [String]?
    let minArgs: Int?
    let maxArgs: Int?
    let helpMessage: String
    
    // MARK: - Public methods
    
    init(args: [String]?, helpMessage: String, minArgs: Int? = nil, maxArgs: Int? = nil) {
        self.args = args
        self.helpMessage = helpMessage
        self.minArgs = minArgs
        self.maxArgs = maxArgs
    }
    
    /// Use it to validate the arguments
    ///
    /// - Throws: the help message if the arguments are not well-formed
    func validate() throws {
        guard let arguments = self.args else { return }
        if let minArgs = self.minArgs, arguments.count < minArgs {
            throw Abort(reason: self.helpMessage)
        }
        if let maxArgs = self.maxArgs, arguments.count > maxArgs {
            throw Abort(reason: self.helpMessage)
        }
    }
    
    /// Use if to validate a specific argument
    ///
    /// - Parameters:
    ///   - index: the argument to validate
    ///   - completion: block for performing the validation
    /// - Throws: the help message if the arguments are not well-formed
    func validate(_ indices: Int..., completion: @escaping ([String]) -> Bool) throws {
        guard let arguments = self.args else { return }
        let values = arguments
            .enumerated()
            .filter { offset, _ in
                indices.contains(offset)
            }.map { _, value in
                value
            }
        if !completion(values) {
            throw Abort(reason: self.helpMessage)
        }
    }
}
