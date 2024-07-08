//
//  Routes.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import Foundation

enum Routes: String {
    
    // MARK: - Most Popular
    case mostPopular = "/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key="
    
    func mostPopularURL() -> URL? {
        guard let urlString = (Constants.baseURL + self.rawValue + Constants.apiKey).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: urlString)
    }
}
