//
//  LanguageSetupViewController.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class LanguageSetupViewController: UIViewController, LanguageSetupPresenterOutput {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var languagesTableView: UITableView!
    
    // MARK: - Public properties
    
    static let storyboardIdentifier = "LanguageSetupViewController"
    var presenter: LanguageSetupPresenterInput?
    
    // MARK: - LanguageSetupPresenterOutput

}
