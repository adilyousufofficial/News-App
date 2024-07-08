//
//  NewsViewModel.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import Foundation

class NewsViewModel {
    
    static func create() -> Resource<News?> {
        
        guard let url =  Routes.mostPopular.mostPopularURL() else {
            fatalError("URL is incorrect!")
        }
        print("url: \(url)")
        
        var resource = Resource<News?>(url: url)
        resource.httpMethod = HttpMethod.get
        return resource
    }
    
    func getNewsArticles(completion: @escaping (_ newsList: News?, _ error: Error?) -> Void) {
        NewsAPIManager().getNewsArticles() { response, error in
            if error == nil {
                completion( response!, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}