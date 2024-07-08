//
//  ImageLoader.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class ImageLoader {
    
    private static var cache = NSCache<NSString, UIImage>()
    
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image from URL:", url)
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                // Cache image
                cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            } else {
                print("Failed to create image from data at URL:", url)
                completion(nil)
            }
            
        }.resume()
    }
}
