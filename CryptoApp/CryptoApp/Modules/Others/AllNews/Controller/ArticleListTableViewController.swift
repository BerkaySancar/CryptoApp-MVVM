//
//  ArticleListTableViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 8.02.2024.
//

import UIKit

final class ArticleListTableViewController: UITableViewController {
    
    //MARK: ViewModel
    var viewModel: ArticleListViewModelProtocol!
        
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }

    // MARK: Table view data source & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListItemCell", for: indexPath) as! ArticleListItemCell
        cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? ArticleListItemVM
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

// MARK: View Model Outputs
extension ArticleListTableViewController: ArticleListViewModelOutputs {
  
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func prepareBarButtonItem() {
        let menu = UIMenu(
            title: "",
            children: [
                UIAction(title: "Sort by date",
                         image: .init(
                            systemName: "arrow.up.arrow.down"
                         ),
                         handler: { [weak self] _ in
                             self?.viewModel.sortByDate()
                         })
            ]
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "arrow.up.arrow.down"), menu: menu)
    }
    
    func registerCell() {
        self.tableView.register(.init(nibName: "ArticleListItemCell", bundle: nil), forCellReuseIdentifier: "ArticleListItemCell")
    }
    
    func dataRefreshed() {
        self.tableView.reloadData()
    }
}
