//
//  System.swift
//  gigigo-release
//
//  Created by José Estela on 28/2/17.
//  Copyright © 2017 José Estela. All rights reserved.
//

import Foundation

struct System {
    
    // MARK: - Command
    
    static func execute(command: String, with params: [String]? = nil) {
        _ = executeWithResult(command: command, with: params)
    }

    static func executeWithResult(command: String, with params: [String]? = nil) -> String {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = command
        task.arguments = params ?? []
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let result = String(data: data, encoding: .utf8) ?? ""
        return result
    }
    
    // MARK: - Files
    
    static func current() -> String {
        return FileManager.default.currentDirectoryPath
    }
    
    static func listItems(in path: String) -> [String]? {
        let directoryContents = try? FileManager.default.contentsOfDirectory(atPath: path)
        return directoryContents
    }
    
    static func listItemsInCurrent() -> [String]? {
        return listItems(in: current())
    }
    
    static func find(in path: String, contains: String) -> Bool {
        guard let items = listItems(in: path) else { return false }
        for item in items {
            if item.contains(contains) {
                return true
            }
        }
        return false
    }
    
    static func moveItem(at path: String, to toPath: String) {
        do {
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: toPath, isDirectory: &isDir) {
                self.removeItem(at: toPath)
                try FileManager.default.moveItem(atPath: path, toPath: toPath)
            } else {
                try FileManager.default.moveItem(atPath: path, toPath: toPath)
            }
        } catch let error {
            print(error)
        }
    }
    
    static func copyItem(at path: String, to toPath: String) {
        do {
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: toPath, isDirectory: &isDir) {
                self.removeItem(at: toPath)
                try FileManager.default.copyItem(atPath: path, toPath: toPath)
            } else {
                try FileManager.default.copyItem(atPath: path, toPath: toPath)
            }
        } catch let error {
            print(error)
        }
    }
    
    static func createFile(at path: String, contents: Data) {
        FileManager.default.createFile(atPath: path, contents: contents, attributes: nil)
    }
    
    static func createDirectory(at path: String) {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error)
        }
    }
    
    static func removeItem(at path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
    
    static func exist(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func contents(atPath path: String) -> Data? {
        return FileManager.default.contents(atPath: path)
    }
}

// MARK: - Public global methods

func pwd() -> String {
    return System.executeWithResult(command: "/bin/pwd").replacingOccurrences(of: "\n", with: "") + "/"
}
