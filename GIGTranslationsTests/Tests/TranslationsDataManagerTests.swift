//
//  TranslationsDataManagerTests.swift
//  GIGTranslationsTests
//
//  Created by José Estela on 14/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import Nimble
import XCTest
@testable import GIGTranslations

class TranslationsDataManagerTests: XCTestCase {
    
    // MARK: - Attributes
    
    var translationsDataManager: TranslationsDataManager!
    var memoryStoreMock: TranslationsStoreMock!
    var diskStoreMock: TranslationsStoreMock!
    var localLoaderMock: TranslationsLoaderMock!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        super.setUp()
        self.memoryStoreMock = TranslationsStoreMock()
        self.diskStoreMock = TranslationsStoreMock()
        self.localLoaderMock = TranslationsLoaderMock()
        self.translationsDataManager = TranslationsDataManager(
            memory: self.memoryStoreMock,
            disk: self.diskStoreMock,
            local: self.localLoaderMock
        )
    }
    
    override func tearDown() {
        self.memoryStoreMock = nil
        self.diskStoreMock = nil
        self.localLoaderMock = nil
        self.translationsDataManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_translationsDataManager_shouldReturnTranslationsFromMemory_ifThereAreTranslationsInMemory() {
        self.memoryStoreMock.translations = TranslationsModel.mock(language: "es")
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es")
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es")
        // Assert
        expect(self.translationsDataManager.loadTranslations(for: "es")) == self.memoryStoreMock.translations
    }
    
    func test_translationsDataManager_shouldReturnTranslationsFromDisk_ifThereAreNotMemoryTranslations_andThereAreDiskTranslations() {
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es")
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es")
        // Assert
        expect(self.translationsDataManager.loadTranslations(for: "es")) == self.diskStoreMock.translations
    }
    
    func test_translationsDataManager_shouldReturnTranslationsFromLocal_ifThereAreNotMemoryAndDiskTranlations() {
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es")
        // Assert
        expect(self.translationsDataManager.loadTranslations(for: "es")) == self.localLoaderMock.translations
    }
    
    func test_translationsDataManager_shouldReturnTranlationForKeyFromMemory_ifThereIsATranlationForThisKeyInMemory() {
        self.memoryStoreMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "memory"])
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "disk"])
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "local"])
        // Assert
        expect(self.translationsDataManager.translation(for: "key")) == "memory"
    }
    
    func test_translationsDataManager_shouldReturnTranlationForKeyFromDisk_ifThereIsNotAnyValueForKeyInMemory_andThereIsATranlationForThisKeyInDisk() {
        self.memoryStoreMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "disk"])
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "local"])
        // Assert
        expect(self.translationsDataManager.translation(for: "key")) == "disk"
    }
    
    func test_translationsDataManager_shouldReturnTranlationForKeyFromLocal_ifThereIsNotAnyValueForKeyInMemoryAndDisk_andThereIsATranlationForThisKeyInLocal() {
        self.memoryStoreMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es", translations: ["key": "local"])
        // Assert
        expect(self.translationsDataManager.translation(for: "key")) == "local"
    }
    
    func test_translationsDataManager_shouldReturnKey_ifThereIsNotAnyTranslationForThisKeyInAllLayers() {
        self.memoryStoreMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        self.diskStoreMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        self.localLoaderMock.translations = TranslationsModel.mock(language: "es", translations: [:])
        // Assert
        expect(self.translationsDataManager.translation(for: "key")) == "key"
    }
}
