//
//  TranslateWireframe.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

protocol TranslateWireframeInput {
    func translateViewController() -> TranslateViewController?
}

struct TranslateWireframe: TranslateWireframeInput {
    
    let navigationController: UINavigationController?
    
    // MARK: - TranslateWireframeInput
    
    func translateViewController() -> TranslateViewController? {
        let storyboard = UIStoryboard(name: AppWireframe.mainStoryboardName, bundle: nil)
        guard let translateVC = storyboard.instantiateViewController(withIdentifier: TranslateViewController.storyboardIdentifier) as? TranslateViewController else {
            return nil
        }
        let wireframe = TranslateWireframe(navigationController: self.navigationController)
        translateVC.presenter = TranslatePresenter(view: translateVC, wireframe: wireframe, interactor: nil) //!!!
        return translateVC
    }
    
}
