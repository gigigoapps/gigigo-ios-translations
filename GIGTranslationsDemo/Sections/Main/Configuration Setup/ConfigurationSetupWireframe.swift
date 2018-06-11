//
//  ConfigurationSetupWireframe.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

protocol ConfigurationSetupWireframeInput {
    func configurationSetupViewController() -> ConfigurationSetupViewController?
}

struct ConfigurationSetupWireframe: ConfigurationSetupWireframeInput {
    
    let navigationController: UINavigationController?
    
    // MARK: - ConfigurationSetupWireframeInput
    
    func configurationSetupViewController() -> ConfigurationSetupViewController? {
        let storyboard = UIStoryboard(name: AppWireframe.mainStoryboardName, bundle: nil)
        guard let configurationSetupVC = storyboard.instantiateViewController(withIdentifier: ConfigurationSetupViewController.storyboardIdentifier) as? ConfigurationSetupViewController else {
            return nil
        }
        configurationSetupVC.presenter = ConfigurationSetupPresenter(view: configurationSetupVC, wireframe: self, interactor: nil) //!!!
        return configurationSetupVC
    }
}
