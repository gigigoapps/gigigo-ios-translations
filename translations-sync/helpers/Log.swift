//
//  Log.swift
//  gigigo-templates
//
//  Created by José Estela on 2/3/17.
//  Copyright © 2017 José Estela. All rights reserved.
//

import Foundation

enum LogLevel: Int {
    /// No log will be shown.
    case none = 0
    
    /// Only warnings and errors.
    case error = 1
    
    /// Errors and relevant information.
    case info = 2
    
    /// Request and Responses will be displayed.
    case debug = 3
}

enum LogColor: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
}

func >= (levelA: LogLevel, levelB: LogLevel) -> Bool {
    return levelA.rawValue >= levelB.rawValue
}


class LogManager {
    static let shared = LogManager()
    
    var appName: String?
    var logLevel: LogLevel = .none
}


func log(_ log: String, color: LogColor = .white) {
    guard LogManager.shared.logLevel != .none else { return }
    let logString = color.rawValue + log + "\u{001B}[0;0m"
    print(logString)
}

func logInfo(_ log: String) {
    guard LogManager.shared.logLevel >= .info else { return }
    
    log(log, color: .green)
}

func logLine() {
    print()
}

func logWarn(_ message: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard LogManager.shared.logLevel >= .error else { return }
    log(message, color: .yellow)
}

func logError(_ error: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard
        LogManager.shared.logLevel >= .error
        else { return }
    log(error, color: .red)
}

extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
