//
//  Popup.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class Popup {
    static func showError(message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
