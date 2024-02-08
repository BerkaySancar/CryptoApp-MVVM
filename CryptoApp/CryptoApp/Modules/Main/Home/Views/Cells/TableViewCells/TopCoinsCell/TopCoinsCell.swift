//
//  TopCoinsCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class TopCoinsCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet private weak var topCoinsCollectionView: UICollectionView!
    
    var viewModel: TopCoinsCellVM! {
        didSet {
            topCoinsCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configure()
    }
    
    private func configure() {
        topCoinsCollectionView.delegate = self
        topCoinsCollectionView.dataSource = self
        topCoinsCollectionView.register(.init(nibName: "TopCoinCell", bundle: nil), forCellWithReuseIdentifier: "TopCoinCell")
    }
    
    @IBAction private func seeAllButtonTapped(_ sender: UIButton) {
        
    }
}

//MARK: CollectionView Delegate & DataSource & FlowLayout
extension TopCoinsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCoinCell", for: indexPath) as! TopCoinCell
        cell.viewModel = viewModel.getCellVM(indexPath: indexPath) as? TopCoinCellVM
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}
