//
//  LanguageSetupPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol LanguageSetupPresenterInput {
    func viewDidLoad()
}

protocol LanguageSetupPresenterOutput: class {
    
}

class LanguageSetupPresenter: LanguageSetupPresenterInput {
    
    weak var view: LanguageSetupPresenterOutput?
    let wireframe: LanguageSetupWireframeInput
    
    // MARK: - Initializer
    
    init(view: LanguageSetupPresenterOutput, wireframe: LanguageSetupWireframeInput, interactor: Any?) {
        self.view = view
        self.wireframe = wireframe
        // self.interactor = interactor
    }
    
    // MARK: - LanguageSetupPresenterInput
    
    func viewDidLoad() {
        
    }
}
