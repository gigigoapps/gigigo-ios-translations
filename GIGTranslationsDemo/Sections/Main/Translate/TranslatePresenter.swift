//
//  TranslatePresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol TranslatePresenterInput {
    func viewDidLoad()
}

protocol TranslatePresenterOutput: class {
}

class TranslatePresenter: TranslatePresenterInput {
    
    weak var view: TranslatePresenterOutput?
    let wireframe: TranslateWireframeInput
    
    // MARK: - Initializer
    
    init(view: TranslatePresenterOutput, wireframe: TranslateWireframeInput, interactor: Any?) {
        self.view = view
        self.wireframe = wireframe
        // self.interactor = interactor
    }

    // MARK: - TranslatePresenterInput
    
    func viewDidLoad() {
        
    }
}
