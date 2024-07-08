//
//  NewsAPIManager.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import Foundation

class NewsAPIManager {
    func getNewsArticles(completion: @escaping (_ response: News?, _ error: String?) -> Void) {
        if let resource = NewsViewModel.createMostPopularResource() {
            NetworkManager().load(resource: resource) { result in
                switch result {
                    case .success(let newsArticles):
                        completion(newsArticles, nil)
                        
                    case .failure(let error):
                        completion(nil, error.localizedDescription)
                        
                }
            }
        } else {
            completion(nil, "Invalid Resources")
        }
    }
}
