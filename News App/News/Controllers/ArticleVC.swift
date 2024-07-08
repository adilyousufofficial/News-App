//
//  ArticleVC.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class ArticleVC: UIViewController {
    
    static let Identifier = "ArticleVC"
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var openArticleButton: UIButton!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
            setupUI(article: article)
        }
    }
    
    private func setupUI(article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.abstract
        loadImage(from: article.media.first?.mediaMetadata.last?.url ?? "")
    }
    
    private func loadImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        
        ImageLoader.loadImage(from: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.bannerImageView.image = image
            }
        }
    }
    
    @IBAction func openArticleButtonTapped(_ sender: UIButton) {
        guard let article = article, let fullArticleUrl = URL(string: article.url) else { return }
        
        if UIApplication.shared.canOpenURL(fullArticleUrl) {
            UIApplication.shared.open(fullArticleUrl, options: [:], completionHandler: nil)
        }
    }
}
