//
//  NewsAPIManager.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import Foundation

class NewsAPIManager {
    func getNewsArticles(completion: @escaping (_ response: News?, _ error: Error?) -> Void) {
        NetworkManager().load(resource: NewsViewModel.create()) { result in
            switch result {
                case .success(let newsArticles):
                    completion(newsArticles, nil)
                    
                case .failure(let error):
                    completion(nil, error)
                    
            }
        }
    }
}
