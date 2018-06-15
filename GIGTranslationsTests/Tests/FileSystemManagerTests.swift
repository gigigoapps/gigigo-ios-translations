//
//  FileSystemManagerTests.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 15/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import GIGTranslations

class FileSystemManagerTests: XCTestCase {
    
    var fileSystemManager: FileSystemManager!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        super.setUp()
        self.fileSystemManager = FileSystemManager(bundle: Bundle(for: FileSystemManagerTests.self))
    }
    
    override func tearDown() {
        self.fileSystemManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_fileSystemManager_shouldReturnTranslations_ifThereIsAJSONFileInTheBundleWithTheLanguageSelected() {
        // Assert
        expect(self.fileSystemManager.loadTranslations(for: "en")).toNot(beNil())
    }
    
    func test_fileSystemManager_shouldReturnNil_ifThereIsNotAJSONFileInTheBundleWithTheLanguageSelected() {
        // Assert
        expect(self.fileSystemManager.loadTranslations(for: "es")).to(beNil())
    }
}
