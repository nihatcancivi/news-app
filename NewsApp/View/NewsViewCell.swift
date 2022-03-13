//
//  NewsViewCell.swift
//  NewsApp
//
//  Created by Nihat on 8.03.2022.
//

import UIKit

class NewsViewCell: UITableViewCell {

    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //imageView kenar yuvarlatma
        self.newsImageView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
