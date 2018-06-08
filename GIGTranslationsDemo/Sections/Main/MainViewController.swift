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
    
    var presenter: MainPresenterInput?

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // FIXME: Set the presenter on the AppWireframe and remove this assignment
        let viewModel = MainViewModel(isConfigured: false, hasLanguage: false)
        self.presenter = MainPresenter(view: self, viewModel: viewModel) // !!!
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
        self.setupButton(self.initializeOptionButton)
        self.setupButton(self.setLanguageOptionButton)
        self.setupButton(self.translateOptionButton)
    }
    
    private func setupButton(_ button: UIButton) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = button.isEnabled ? button.tintColor.cgColor : UIColor.lightGray.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
