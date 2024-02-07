//
//  NewsDetailViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import UIKit
import Kingfisher

final class NewsDetailViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleDescriptionLabel: UILabel!
    @IBOutlet private weak var articleContentLabel: UILabel!
    
    //MARK: ViewModel
    var viewModel: NewsDetailViewModelProtocol!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    @IBAction private func didTapToReadWebView(_ sender: Any) {
        viewModel.didTapToReadWebView()
    }
    
    @objc private func actionTapped() {
        viewModel.actionButtonTapped()
    }
}

//MARK: View Model Outputs
extension NewsDetailViewController: NewsDetailViewModelOutputs {
    
    func showArticle(article: ArticleModel?) {
        if let article {
            if let imageURLString = article.urlToImage,
               let imageURL = URL(string: imageURLString) {
                articleImageView.kf.setImage(with: imageURL)
                articleTitleLabel.text = article.title
                articleContentLabel.text = article.content
                articleDescriptionLabel.text = article.description
            }
        } 
    }
    
    func prepareActionButton() {
        self.navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(
                actionTapped
            )
        )
    }
    
    func presentActionController(url: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        present(
            activityViewController,
            animated: true,
            completion: nil
        )
    }
}
