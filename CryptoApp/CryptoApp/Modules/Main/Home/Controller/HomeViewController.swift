//
//  HomeViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
    //MARK: ViewModel
    var viewModel: HomeViewModelProtocol!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

// MARK: View Model Outputs
extension HomeViewController: HomeViewModelOutputs {
    
    func setNavTitle(title: String) {
        self.tabBarController?.title = title
    }
    
    func dataRefreshed() {
        self.homeTableView.reloadData()
    }
}

//MARK: Table View Delegate & Data Source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeViewCellType.getType(index: indexPath.row) {
        case .totalBalance:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalBalanceCell", for: indexPath) as! TotalBalanceCell
            return cell
        case .topCoins:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCoinsCell", for: indexPath) as! TopCoinsCell
            cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? TopCoinsCellVM
            return cell
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? NewsCellViewModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRowAt(indexPath: indexPath)
    }
}
