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
    
    // MARK: - Private properties
    
    var viewModel: LanguageSetupViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languagesTableView.delegate = self
        self.languagesTableView.dataSource = self
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - LanguageSetupPresenterOutput
    
    func loadView(viewModel: LanguageSetupViewModel) {
        self.viewModel = viewModel
        self.languagesTableView.reloadData()
    }
    
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
}

extension LanguageSetupViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.languages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.reuseIdentifier, for: indexPath) as? LanguageTableViewCell,
            let viewModel = self.viewModel,
            viewModel.languages.count > indexPath.row
        else {
            return UITableViewCell()
        }
        let language = viewModel.languages[indexPath.row]
        cell.setup(languageKey: language)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel, viewModel.languages.count > indexPath.row, let languageKey = self.viewModel?.languages[indexPath.row] else { return }
        self.presenter?.userSelectedLanguage(key: languageKey)
    }
}
