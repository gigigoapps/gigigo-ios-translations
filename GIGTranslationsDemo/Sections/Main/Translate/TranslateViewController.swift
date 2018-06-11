//
//  TranslateViewController.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, TranslatePresenterOutput {
    
    // MARK: - IBOutlets

    @IBOutlet weak var translationsTableView: UITableView!
    
    // MARK: - Public properties
    
    static let storyboardIdentifier = "TranslateViewController"
    var presenter: TranslatePresenterInput?
    
    // MARK: - TranslatePresenterOutput
}
