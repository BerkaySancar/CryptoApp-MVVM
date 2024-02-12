//
//  TotalBalanceCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class ExchangesCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet private weak var exchangesCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    //MARK: ViewModel
    var viewModel: ExchangesCellViewModel! {
        didSet {
            self.exchangesCollectionView.reloadData()
            self.pageControl.numberOfPages = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        exchangesCollectionView.delegate = self
        exchangesCollectionView.dataSource = self
        exchangesCollectionView.register(.init(nibName: "ExchangeCell", bundle: nil), forCellWithReuseIdentifier: "ExchangeCell")
        exchangesCollectionView.decelerationRate = .fast
    }
}

extension ExchangesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCell", for: indexPath) as! ExchangeCell
        cell.viewModel = viewModel.getCellViewModel(indexPath: indexPath) as? ExchangeCellVM
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width, height: self.frame.height - 76)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
