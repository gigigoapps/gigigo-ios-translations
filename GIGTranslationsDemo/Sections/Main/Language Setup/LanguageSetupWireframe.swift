//
//  LanguageSetupWireframe.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

protocol LanguageSetupWireframeInput {
    func languageSetupViewController() -> LanguageSetupViewController?
    func dismiss()
}

struct LanguageSetupWireframe: LanguageSetupWireframeInput {
    
    let navigationController: UINavigationController?
    
    // MARK: - LanguageSetupWireframeInput
    
    func languageSetupViewController() -> LanguageSetupViewController? {
        let storyboard = UIStoryboard(name: AppWireframe.mainStoryboardName, bundle: nil)
        guard let languageSetupVC = storyboard.instantiateViewController(withIdentifier: LanguageSetupViewController.storyboardIdentifier) as? LanguageSetupViewController else {
            return nil
        }
        let interactor = TranslationsInteractor()
        languageSetupVC.presenter = LanguageSetupPresenter(view: languageSetupVC, interactor: interactor, wireframe: self)
        return languageSetupVC
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
