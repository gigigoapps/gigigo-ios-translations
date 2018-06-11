//
//  ConfigurationSetupPresenter.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

protocol ConfigurationSetupPresenterInput {
    func viewDidLoad()
}

protocol ConfigurationSetupPresenterOutput: class {
}

class ConfigurationSetupPresenter: ConfigurationSetupPresenterInput {
    
    weak var view: ConfigurationSetupPresenterOutput?
    let wireframe: ConfigurationSetupWireframeInput
    
    // MARK: - Initializer
    
    init(view: ConfigurationSetupPresenterOutput, wireframe: ConfigurationSetupWireframeInput, interactor: Any?) {
        self.view = view
        self.wireframe = wireframe
        // self.interactor = interactor
    }

    // MARK: - ConfigurationSetupPresenterInput
    
    func viewDidLoad() {
        
    }
}
