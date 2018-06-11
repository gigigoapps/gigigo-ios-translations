//
//  ViewController.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 08/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var initializeOptionButton: UIButton!
    @IBOutlet weak var setLanguageOptionButton: UIButton!
    @IBOutlet weak var translateOptionButton: UIButton!
    
    // MARK: - Public properties
    
    static let storyboardIdentifier = "MainViewController"
    var presenter: MainPresenterInput?

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapOnInitializeButton(_ sender: Any) {
        self.presenter?.userSelectedInitializeOption()
    }
    
    @IBAction func didTapOnSetLanguageButton(_ sender: Any) {
        self.presenter?.userSelectedSetLanguageOption()
    }
    
    @IBAction func didTapOnTranslateButton(_ sender: Any) {
        self.presenter?.userSelectedTranslateOption()
    }

    // MARK: - Private methods
    
    private func setupView() {        
        self.initializeOptionButton.setupRoundedButton()
        self.setLanguageOptionButton.setupRoundedButton()
        self.translateOptionButton.setupRoundedButton()
    }
}

extension MainViewController: MainPresenterOutput {
    
    func loadView(with viewModel: MainViewModel) {
        self.initializeOptionButton.isEnabled = viewModel.isConfigured ? false : true
        self.setLanguageOptionButton.isEnabled = viewModel.isConfigured ? true : false
        self.translateOptionButton.isEnabled = viewModel.isConfigured && viewModel.hasLanguage ? true : false
        self.setupView()
    }
}
