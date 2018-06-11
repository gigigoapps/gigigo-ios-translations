//
//  MainPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol MainPresenterInput {
    func viewDidLoad()
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
    
    // MARK: - Initializer
    
    init(view: MainPresenterOutput, wireframe: MainWireframeInput, viewModel: MainViewModel) {
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
    }
    
    // MARK: - MainPresenterInput
    
    func viewDidLoad() {
        guard let viewModel = self.viewModel else { return }
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
