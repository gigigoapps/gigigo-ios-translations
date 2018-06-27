//
//  TranslationFile.swift
//  translations-sync
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct TranslationsFile {
    
    // MARK: - Public attributes
    
    let language: String
    let platform: Platform
    
    // MARK: - Public methods
    
    func set(content: Data) throws {
        switch self.platform {
        case .android, .iOS:
            if !System.exist(path: folderPath()) {
                System.createDirectory(at: folderPath())
            }
            System.createFile(at: filePath(), contents: content)
        case .universal:
            System.createFile(at: filePath(), contents: content)
        }
    }
    
    func exist() -> Bool {
        return System.exist(path: filePath())
    }
    
    // MARK: - Private methods
    
    private func filePath() -> String {
        switch self.platform {
        case .universal:
            return folderPath() + self.language + "." + self.platform.fileExtension()
        case .iOS:
            return folderPath() + "/Localizable." + self.platform.fileExtension()
        case .android:
            return folderPath() + "strings." + self.platform.fileExtension()
        }
    }
    
    private func folderPath() -> String {
        switch self.platform {
        case .universal:
            return pwd()
        case .iOS:
            return pwd() + self.language + ".lproj/"
        case .android:
            return pwd() + "values-" + self.language + "/"
        }
    }
}
