//
//  NewsCell.swift
//  News App
//
//  Created by Adil Yousuf on 08/07/2024.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let nibName = "NewsCell"
    static let Identifier = "NewsCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Make the image circular
        newsImageView.layer.cornerRadius = newsImageView.frame.size.width / 2
        newsImageView.clipsToBounds = true
    }
}
