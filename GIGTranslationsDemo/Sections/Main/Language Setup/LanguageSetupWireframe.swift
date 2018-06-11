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
}

struct LanguageSetupWireframe: LanguageSetupWireframeInput {
    
    let navigationController: UINavigationController?
    
    // MARK: - LanguageSetupWireframeInput
    
    func languageSetupViewController() -> LanguageSetupViewController? {
        let storyboard = UIStoryboard(name: AppWireframe.mainStoryboardName, bundle: nil)
        guard let languageSetupVC = storyboard.instantiateViewController(withIdentifier: LanguageSetupViewController.storyboardIdentifier) as? LanguageSetupViewController else {
            return nil
        }
        languageSetupVC.presenter = LanguageSetupPresenter(view: languageSetupVC, wireframe: self, interactor: nil) //!!!
        return languageSetupVC
    }
}
