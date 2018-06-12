//
//  ConfigurationSetupPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol ConfigurationSetupPresenterInput {
    func userEnteredText(_ text: String?)
}

protocol ConfigurationSetupPresenterOutput: class {
    func showAlert(title: String, message: String)
    func showLoader()
    func dismissLoader()
}

class ConfigurationSetupPresenter: ConfigurationSetupPresenterInput {
    
    weak var view: ConfigurationSetupPresenterOutput?
    let wireframe: ConfigurationSetupWireframeInput
    let interactor: TranslationsInteractorInput
    
    // MARK: - Initializer
    
    init(view: ConfigurationSetupPresenterOutput, wireframe: ConfigurationSetupWireframeInput, interactor: TranslationsInteractorInput) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }

    // MARK: - ConfigurationSetupPresenterInput
    
    func userEnteredText(_ text: String?) {
        guard let text = text, !text.isEmpty else {
            self.handleError()
            return
        }
        self.view?.showLoader()
        self.interactor.configureTranslations(with: text) { (result) in
            self.view?.dismissLoader()
            if result {
                self.wireframe.dismiss()
            } else {
                self.handleError()
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func handleError() {
        self.view?.showAlert(title: "Error", message: "Please enter a valid name for configuration file")
    }
}
