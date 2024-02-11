//
//  SearchViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var trendingSearchLabel: UILabel!
    
    private lazy var emptyContentView: EmptyContentView = {
        let view = EmptyContentView()
        view.iconImageView.image = .init(systemName: "exclamationmark.magnifyingglass")
        view.messageLabel.text = "Searched currency not found!"
        return view
    }()
    
    //MARK: View Model
    var viewModel: SearchViewModelProtocol!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        searchBar.setPlaceholderColor(.appYellow.withAlphaComponent(0.90))
        searchBar.setMagnifyingGlassColorTo(color: .appYellow)
        searchBar.searchTextField.textColor = .appYellow
        searchBar.searchTextField.becomeFirstResponder()
    }
}

//MARK: View Model Outputs
extension SearchViewController: SearchViewModelOutputs {
    
    func setNavTitle(title: String) {
        self.tabBarController?.title = title
    }
    
    func dataRefreshed() {
        self.searchTableView.reloadData()
    }
    
    func didChangeTrendLabelVisibility(_ isHidden: Bool) {
        self.trendingSearchLabel.isHidden = isHidden
    }
    
    func prepareEmptyContentView() {
        searchTableView.backgroundView = emptyContentView
    }
}

//MARK: UISearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(text: searchText)
    }
}

//MARK: UITableView Delegate & Data Source
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchTableView.backgroundView?.isHidden = viewModel.numberOfRowsInSection(section: section) != 0
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCoinCell", for: indexPath) as! SearchCoinCell
        cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? SearchCoinCellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}
