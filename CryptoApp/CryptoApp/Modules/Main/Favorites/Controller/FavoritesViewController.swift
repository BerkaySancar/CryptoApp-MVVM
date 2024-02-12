//
//  FavoritesViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var favoritesTableView: UITableView!
    
    //MARK: EmtyContentView
    private lazy var emptyContentView: EmptyContentView = {
        let view = EmptyContentView()
        view.iconImageView.image = .init(systemName: "heart")
        view.messageLabel.text = "Favorites are empty!"
        return view
    }()
    
    //MARK: ViewModel
    var viewModel: FavoritesViewModelProtocol!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    //MARK: Actions
    @objc
    private func deleteAllTapped() {
        viewModel.deleteAllTapped()
    }
}

//MARK: View Model Outputs
extension FavoritesViewController: FavoritesViewModelOutputs {
    
    func setNavTitle(title: String) {
        self.tabBarController?.title = title
    }
    
    func prepareNavBarButtons() {
        let menu = UIMenu(
            title: "",
            children: [
                UIAction(title: "Delete all",
                         subtitle: "To delete all favorites.",
                         image: .init(
                            systemName: "trash"
                         ),
                         attributes: .destructive,
                         handler: { [weak self] _ in
                             self?.viewModel.deleteAllTapped()
                         })
            ]
        )
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "trash"), menu: menu)
    }
    
    func removeNavBarButtons() {
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
    }
    
    func prepareEmptyView() {
        self.favoritesTableView.backgroundView = emptyContentView
    }

    func dataRefreshed() {
        self.favoritesTableView.reloadData()
    }
}

//MARK: TableView Delegate & Data Source
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesTableView.backgroundView?.isHidden = viewModel.numberOfRowsIn(section: section) != 0
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? FavoriteCellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeItem(indexPath: indexPath)
        }
    }
}
