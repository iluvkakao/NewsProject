//
//  NewsTableViewCell.swift
//  NewsProject
//
//  Created by Natallia Askerka on 25.08.21.
//

import UIKit
import SDWebImage



final class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsSubtitleLabel: UILabel!
    
 
    
    
    func configureWith(model: NewsTableViewCellModel ){
        newsTitleLabel.text = model.title
        newsSubtitleLabel.text = model.subtitle
     
        DispatchQueue.main.async {
            self.newsImageView.sd_setImage(with: URL(string: model.imageURL ?? ""), placeholderImage: UIImage(named: "news-placeholder"), options: .refreshCached, context: nil)
        }

//        newsImageView.layer.cornerRadius = 6
        }
        

    }
    

