//
//  UserDefaultsManagerTests.swift
//  GIGTranslationsTests
//
//  Created by Jerilyn Goncalves on 15/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation
import Nimble
import XCTest
@testable import GIGTranslations

class UserDefaultsManagerTests: XCTestCase {
    
    // MARK: - Attributes
    
    var userDefaultsMock: UserDefaultsMock!
    var userDefaultsManager: UserDefaultsManager!
    var configuration: ConfigurationModel!
    var language: String!
    var translations: TranslationsModel!
    
    // MARK: - Test life cycle
    
    override func setUp() {
        super.setUp()
        self.language = "es"
        let configurationURL = URL(string: "https://gigigo.translations.ie/config") ?? URL(fileURLWithPath: "")
        let translationsURL = URL(string: "https://gigigo.translations.ie/" + language) ?? URL(fileURLWithPath: "")
        self.configuration = ConfigurationModel(
            path: configurationURL,
            lastUpdateDate: Date(),
            languages: [language: translationsURL]
        )
        self.translations = TranslationsModel(
            language: language,
            lastUpdateDate: Date(),
            translations: ["key": "value"]
        )
        self.userDefaultsMock = UserDefaultsMock()
        self.userDefaultsManager = UserDefaultsManager(userDefaults: self.userDefaultsMock)
    }

    override func tearDown() {
        self.userDefaultsMock = nil
        self.userDefaultsManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_userDefaultsManager_savesConfigurationSuccessfully() {
        // Act
        self.userDefaultsManager.save(configuration: self.configuration)
        // Assert
        expect(self.userDefaultsManager.loadConfiguration()).to(beAKindOf(ConfigurationModel.self))
        expect(self.userDefaultsManager.loadConfiguration()?.path) == self.configuration.path
        expect(self.userDefaultsManager.loadConfiguration()?.lastUpdateDate) == self.configuration.lastUpdateDate
        expect(self.userDefaultsManager.loadConfiguration()?.languages) == self.configuration.languages
    }
    
    func test_userDefaultsManager_savesLanguageSuccessfully() {
        // Act
        self.userDefaultsManager.save(language: self.language)
        // Assert
        expect(self.userDefaultsManager.loadLanguage()).to(beAKindOf(String.self))
        expect(self.userDefaultsManager.loadLanguage()) == self.language
    }
    
    func test_userDefaultsManager_savesTranslationsSuccessfully() {
        // Act
        self.userDefaultsManager.save(translations: self.translations)
        // Assert
        expect(self.userDefaultsManager.loadTranslations(for: self.language)).to(beAKindOf(TranslationsModel.self))
        expect(self.userDefaultsManager.loadTranslations(for: self.language)?.translations) == self.translations.translations
    }
    
    func test_userDefaultsManager_getTranslation_whenTranslationsAreConfigured() {
        // Act
        self.userDefaultsManager.save(language: self.language)
        self.userDefaultsManager.save(translations: self.translations)
        // Assert
        expect(self.userDefaultsManager.translation(for: "key")).toNot(beNil())
        expect(self.userDefaultsManager.translation(for: "key")) == "value"
    }
    
    func test_userDefaultsManager_resetTranslationsSuccessfully() {
        // Act
        self.userDefaultsManager.save(language: self.language)
        self.userDefaultsManager.save(translations: self.translations)
        self.userDefaultsManager.resetTranslations()
        // Assert
        expect(self.userDefaultsManager.loadTranslations(for: self.language)).to(beNil())
    }
}
