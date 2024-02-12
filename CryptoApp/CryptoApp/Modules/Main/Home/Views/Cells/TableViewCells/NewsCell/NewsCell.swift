//
//  NewsCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class NewsCell: UITableViewCell {

    @IBOutlet private weak var newsCollectionView: UICollectionView!
    
    var viewModel: NewsCellViewModel! {
        didSet {
            newsCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(.init(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
        newsCollectionView.decelerationRate = .fast
    }
    
    @IBAction func seeAllArticlesTapped(_ sender: Any) {
        viewModel.seeAllArticlesTapped()
    }
}

extension NewsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.viewModel = viewModel.getCellVM(indexPath: indexPath) as? ArticleCellViewModel
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
