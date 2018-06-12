//
//  MainPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

struct MainViewModel {
    var isConfigured: Bool
    var hasLanguage: Bool
}

protocol MainPresenterInput {
    func viewWillAppear()
    func userSelectedInitializeOption()
    func userSelectedSetLanguageOption()
    func userSelectedTranslateOption()
}

protocol MainPresenterOutput: class {
    func loadView(with viewModel: MainViewModel)
}

class MainPresenter: MainPresenterInput {
        
    weak var view: MainPresenterOutput?
    private var viewModel: MainViewModel?
    let wireframe: MainWireframeInput
    let interactor: TranslationsInteractorInput
    
    // MARK: - Initializer
    
    init(view: MainPresenterOutput, interactor: TranslationsInteractorInput, wireframe: MainWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    // MARK: - MainPresenterInput
    
    func viewWillAppear() {
        let viewModel = MainViewModel(isConfigured: self.interactor.isConfigured(), hasLanguage: self.interactor.hasLanguage())
        self.viewModel = viewModel
        self.view?.loadView(with: viewModel)
    }
    
    func userSelectedInitializeOption() {
        self.wireframe.showConfigurationSetup()
    }
    
    func userSelectedSetLanguageOption() {
        self.wireframe.showLanguageSetup()
    }
    
    func userSelectedTranslateOption() {
        self.wireframe.showTranslate()
    }
}
