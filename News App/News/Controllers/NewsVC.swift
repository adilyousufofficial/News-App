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
        
        // Register the cell class or nib
        tableView.register(UINib(nibName: NewsCell.nibName, bundle: nil), forCellReuseIdentifier: NewsCell.Identifier)
        
        tableView.dataSource = newsAdapter
        tableView.delegate = newsAdapter
        
        // Initialize and configure the activity indicator
        activityIndicator = ActivityIndicator(view: self.view)
        
        // Show the activity indicator before starting the API call
        activityIndicator.start()
        
        newsViewModelObject.getNewsArticles { [weak self] newsList, error in
            DispatchQueue.main.async {
                // Hide the activity indicator
                self?.activityIndicator.stop()
            }
            
            guard let self = self else { return }
            if let newsList = newsList {
                self.newsAdapter.updateNewsList(newsList.articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                // Show error alert
                DispatchQueue.main.async {
                    Popup.showError(message: error.localizedDescription, on: self)
                }
            }
        }
    }
}
