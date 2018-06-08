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

    // MARK: - Initializer
    
    init(view: MainPresenterOutput, viewModel: MainViewModel) {
        self.view = view
        self.viewModel = viewModel
    }
    
    // MARK: - MainPresenterInput
    
    func viewDidLoad() {
        guard let viewModel = self.viewModel else { return }
        self.view?.loadView(with: viewModel)
    }
    
    func userSelectedInitializeOption() {
        // TODO: Navigate to view with file name setup
        self.viewModel?.isConfigured = true // !!!
    }
    
    func userSelectedSetLanguageOption() {
        // TODO: Navigate to view with language key setup
        self.viewModel?.hasLanguage = true // !!!
    }
    
    func userSelectedTranslateOption() {
        // TODO: Navigate to view with translations options
    }
}
