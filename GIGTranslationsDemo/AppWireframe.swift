//
//  AppWireframe.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 11/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit
import Foundation

class AppWireframe: NSObject {
    
    static let shared = AppWireframe()
    static let mainStoryboardName = "Main"
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func showMainSection() {
        let navigationController = UINavigationController()
        let wireframe = MainWireframe(navigationController: navigationController)
        guard let mainVC = wireframe.mainViewController() else {
            return
        }
        navigationController.addChildViewController(mainVC)
        self.navigationController = navigationController
        self.window?.rootViewController = navigationController
    }
}
