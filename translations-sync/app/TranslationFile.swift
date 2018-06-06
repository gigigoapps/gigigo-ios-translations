//
//  TranslationFile.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct TranslationFile {
    
    // MARK: - Public attributes
    
    let language: String
    
    // MARK: - Public methods
    
    func set(contents: [String: String]) throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        try System.createFile(at: pwd() + "/" + self.language + ".json", contents: jsonEncoder.encode(contents))
    }
    
    func exist() -> Bool {
        return System.exist(path: pwd() + "/" + self.language + ".json")
    }
}
