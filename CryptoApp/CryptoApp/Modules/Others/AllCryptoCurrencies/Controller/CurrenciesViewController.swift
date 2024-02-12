//
//  CurrenciesViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 9.02.2024.
//

import UIKit


final class CurrenciesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: ViewModel
    var viewModel: CurrenciesViewModelProtocol!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCoinCell", for: indexPath) as! TopCoinCell
        cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? TopCoinCellVM
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.appYellow.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

//MARK: View Model Outputs
extension CurrenciesViewController: CurrenciesViewModelOutputs {
    
    func registerCell() {
        collectionView.register(.init(nibName: "TopCoinCell", bundle: nil), forCellWithReuseIdentifier: "TopCoinCell")
    }
    
    func setNavTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func dataRefreshed() {
        self.collectionView.reloadData()
    }
    
    func prepareBarButtonItem() {
        let menu = UIMenu(
            title: "",
            children: [
                UIAction(title: "Sort by price",
                         image: .init(
                            systemName: "dollarsign"
                         ),
                         handler: { [weak self] _ in
                             self?.viewModel.sortButtonTapped(.sortByPrice)
                         }),
                UIAction(title: "Sort by name",
                         image: .init(
                            systemName: "character"
                         ),
                         handler: { [weak self] _ in
                             self?.viewModel.sortButtonTapped(.sortByName)
                         }),
                UIAction(title: "Sort by price change (24h)",
                         image: .init(
                            systemName: "24.circle.fill"
                         ),
                         handler: { [weak self] _ in
                             self?.viewModel.sortButtonTapped(.sortByPriceChange)
                         }),
            ]
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "arrow.up.arrow.down"), menu: menu)
    }
}
