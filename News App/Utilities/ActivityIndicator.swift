//
//  ActivityIndicator.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class ActivityIndicator {
    private var activityIndicator: UIActivityIndicatorView
    
    init(view: UIView) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
    }
}
