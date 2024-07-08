//
//  NewsAdapter.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class NewsAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var newsList: [Article] = []
    weak var parentViewController: UIViewController?
    
    func updateNewsList(_ newsList: [Article]) {
        self.newsList = newsList
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.Identifier, for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        let article = newsList[indexPath.row]
        cell.titleLabel.text = article.title
        cell.bylineLabel.text = article.byline
        cell.dateLabel.text = article.publishedDate
        
        if let imageUrlString = article.media.first?.mediaMetadata.first?.url,
           let imageUrl = URL(string: imageUrlString) {
            // Use ImageLoader to load image asynchronously
            ImageLoader.loadImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.newsImageView.image = image
                }
            }
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let parentViewController = parentViewController else { return }
        
        let selectedArticle = newsList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        if let articleVC = storyboard.instantiateViewController(withIdentifier: ArticleVC.Identifier) as? ArticleVC {
            articleVC.article = selectedArticle
            parentViewController.navigationController?.pushViewController(articleVC, animated: true)
        }
    }
}
