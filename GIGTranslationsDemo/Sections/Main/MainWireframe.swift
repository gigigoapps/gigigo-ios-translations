//
//  MainWireframe.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

protocol MainWireframeInput {
    
    func mainViewController() -> MainViewController?
    func showConfigurationSetup()
    func showLanguageSetup()
    func showTranslate()
}

struct MainWireframe: MainWireframeInput {
    
    var navigationController: UINavigationController?
    
    // MARK: - MainWireframeInput
    
    func mainViewController() -> MainViewController? {
        let storyboard = UIStoryboard(name: AppWireframe.mainStoryboardName, bundle: nil)
        guard let mainVC = storyboard.instantiateViewController(withIdentifier: MainViewController.storyboardIdentifier) as? MainViewController else {
            return nil
        }
        let interactor = TranslationsInteractor()
        mainVC.presenter = MainPresenter(view: mainVC, interactor: interactor, wireframe: self)
        return mainVC
    }
    
    func showConfigurationSetup() {
        let wireframe = ConfigurationSetupWireframe(navigationController: self.navigationController)
        guard let configurationSetupVC = wireframe.configurationSetupViewController() else {
            return
        }
        self.navigationController?.pushViewController(configurationSetupVC, animated: true)
    }
    
    func showLanguageSetup() {
        let wireframe = LanguageSetupWireframe(navigationController: self.navigationController)
        guard let languageSetupVC = wireframe.languageSetupViewController() else {
            return
        }
        self.navigationController?.pushViewController(languageSetupVC, animated: true)
    }
    
    func showTranslate() {
        let wireframe = TranslateWireframe(navigationController: self.navigationController)
        guard let translateVC = wireframe.translateViewController() else {
            return
        }
        self.navigationController?.pushViewController(translateVC, animated: true)
    }
}
