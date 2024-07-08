//
//  NewsVC.swift
//  News App
//
//  Created by Adil Yousuf on 07/07/2024.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let newsViewModelObject = NewsViewModel()
    let newsAdapter = NewsAdapter()
    var activityIndicator: ActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NY Times Most Popular"
        
        tableView.register(UINib(nibName: NewsCell.nibName, bundle: nil), forCellReuseIdentifier: NewsCell.Identifier)
        
        tableView.dataSource = newsAdapter
        tableView.delegate = newsAdapter
        newsAdapter.parentViewController = self
        
        activityIndicator = ActivityIndicator(view: self.view)
        
        activityIndicator.start()
        
        newsViewModelObject.getNewsArticles { [weak self] newsList, errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stop()
            }
            
            guard let self = self else { return }
            if let newsList = newsList {
                self.newsAdapter.updateNewsList(newsList.articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let message = errorMessage {
                DispatchQueue.main.async {
                    Popup.showError(message: message, on: self)
                }
            }
        }
    }
}
