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

    // MARK: - Private properties
    
    var loadingView: LoadingView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Private methods
    
    func setupView() {
        self.setupButton.setupRoundedButton()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapOnSetupButton(_ sender: Any) {
        self.presenter?.userEnteredText(self.configuratioFileTextField.text)
    }
    
    // MARK: - ConfigurationSetupPresenterOutput
    
    func showAlert(title: String, message: String) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoader() {
        if self.loadingView == nil {
            let loadingView = LoadingView(text: "Loading")
            self.view.addSubview(loadingView)
            self.loadingView = loadingView
        }
        self.loadingView?.show()
    }
    
    func dismissLoader() {
        self.loadingView?.hide()
    }
}
