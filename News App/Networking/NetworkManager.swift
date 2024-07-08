//
//  NetworkManager.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
    var jwtToken: String? = ""
}

class NetworkManager: NSObject, URLSessionDelegate {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let jwtToken = resource.jwtToken, !jwtToken.isEmpty {
            let authValue = "Bearer \(jwtToken)"
            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        task.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                
                let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                print("Error parsing JSON: \(error)")
                print("error: \(String(describing: error))")
                completion(.failure(error))
            }
            
        }.resume()
    }
}
