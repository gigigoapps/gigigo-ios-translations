//
//  TranslatePresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct TranslateViewModel {
    var translations: [(key: String, value: String)]
}

protocol TranslatePresenterInput {
    func viewDidLoad()
}

protocol TranslatePresenterOutput: class {
    func loadView(viewModel: TranslateViewModel)
}

class TranslatePresenter: TranslatePresenterInput {
    
    weak var view: TranslatePresenterOutput?
    let wireframe: TranslateWireframeInput
    let interactor: TranslationsInteractorInput
    
    // MARK: - Initializer
    
    init(view: TranslatePresenterOutput, interactor: TranslationsInteractorInput, wireframe: TranslateWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }

    // MARK: - TranslatePresenterInput
    
    func viewDidLoad() {
        var translations = [(String, String)]()
        for translation in self.interactor.getTranslations() {
            translations.append(translation)
        }
        let viewModel = TranslateViewModel(translations: translations)
        self.view?.loadView(viewModel: viewModel)
    }
}
