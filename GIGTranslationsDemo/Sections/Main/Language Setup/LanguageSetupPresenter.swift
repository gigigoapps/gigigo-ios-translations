//
//  LanguageSetupPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct LanguageSetupViewModel {
    var languages: [String]
}

protocol LanguageSetupPresenterInput {
    func viewDidLoad()
    func userSelectedLanguage(key: String)
}

protocol LanguageSetupPresenterOutput: class {
    func loadView(viewModel: LanguageSetupViewModel)
    func showAlert(title: String, message: String)
}

class LanguageSetupPresenter: LanguageSetupPresenterInput {
    
    weak var view: LanguageSetupPresenterOutput?
    let interactor: TranslationsInteractorInput
    let wireframe: LanguageSetupWireframeInput
    
    // MARK: - Initializer
    
    init(view: LanguageSetupPresenterOutput, interactor: TranslationsInteractorInput, wireframe: LanguageSetupWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - LanguageSetupPresenterInput
    
    func viewDidLoad() {
        let viewModel = LanguageSetupViewModel(languages: self.interactor.getLanguages())
        self.view?.loadView(viewModel: viewModel)
    }
    
    func userSelectedLanguage(key: String) {
        self.interactor.setLanguage(key) { (result) in
            if result {
                self.wireframe.dismiss()
            } else {
                self.handleError()
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func handleError() {
        self.view?.showAlert(title: "Error", message: "The selected language is not valid")
    }
}
