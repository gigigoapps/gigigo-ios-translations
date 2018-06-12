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
    
    // MARK: - Private properties
    
    var viewModel: TranslateViewModel?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.translationsTableView.delegate = self
        self.translationsTableView.dataSource = self
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - TranslatePresenterOutput
    
    func loadView(viewModel: TranslateViewModel) {
        self.viewModel = viewModel
        self.translationsTableView.reloadData()
    }
}

extension TranslateViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.translations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TranslateTableViewCell.reuseIdentifier, for: indexPath) as? TranslateTableViewCell,
            let viewModel = self.viewModel,
            viewModel.translations.count > indexPath.row
            else {
                return UITableViewCell()
        }
        let translation = viewModel.translations[indexPath.row]
        cell.setup(key: translation.key, value: translation.value)
        return cell
    }
}
