//
//  NewsAdapter.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class NewsAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var newsList: [Article] = []
    
    func updateNewsList(_ newsList: [Article]) {
        self.newsList = newsList
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        
        let article = newsList[indexPath.row]
        cell.titleLabel.text = article.title
        cell.bylineLabel.text = article.byline
        cell.dateLabel.text = article.publishedDate
        
        if let imageUrlString = article.media.first?.mediaMetadata.first?.url,
           let imageUrl = URL(string: imageUrlString) {
            // Load the image asynchronously
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.newsImageView.image = image
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection if needed
    }
}
