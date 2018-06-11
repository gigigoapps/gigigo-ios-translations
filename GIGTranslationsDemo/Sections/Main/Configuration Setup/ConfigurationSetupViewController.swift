//
//  ConfigurationSetupViewController.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class ConfigurationSetupViewController: UIViewController, ConfigurationSetupPresenterOutput {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var configuratioFileTextField: UITextField!
    @IBOutlet weak var setupButton: UIButton!
    
    // MARK: - Public properties
    
    static let storyboardIdentifier = "ConfigurationSetupViewController"
    var presenter: ConfigurationSetupPresenterInput?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    func setupView() {
        self.setupButton.setupRoundedButton()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapOnSetupButton(_ sender: Any) {
    }
    
    // MARK: - ConfigurationSetupPresenterOutput

}
