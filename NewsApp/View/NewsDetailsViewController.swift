//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Nihat on 13.03.2022.
//

import UIKit
import Kingfisher

class NewsDetailsViewController: UIViewController {
    
    var newsArticlesVM : NewsArticlesViewModel!
    var url : String?
    
    @IBOutlet weak var newsDetailsDescriptionLabel: UILabel!
    @IBOutlet weak var newsDetailsAuthorLabel: UILabel!
    @IBOutlet weak var newsDetailsDateLabel: UILabel!
    @IBOutlet weak var newsDetailsTitleLabel: UILabel!
    @IBOutlet weak var newsDetailsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDetailsImageView.layer.cornerRadius = 10
    
        newsDetailsTitleLabel.text = newsArticlesVM.title
        newsDetailsDescriptionLabel.text = newsArticlesVM.description
        newsDetailsAuthorLabel.text = newsArticlesVM.author
        newsDetailsDateLabel.text = newsArticlesVM.publishedAt
        newsDetailsImageView.kf.setImage(with: URL(string:newsArticlesVM.urlToImage))
        
        let favouriteImage = UIImage(named: "heart")
        let shareImage = UIImage(named: "share")

        let favouriteButton = UIBarButtonItem(image: favouriteImage, style: .plain, target: self, action: #selector(addFavourite))
        let shareButton = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(shareURL))
        self.navigationItem.rightBarButtonItems = [favouriteButton,shareButton]
        
    }
    @IBAction func newsSourceButtonClicked(_ sender: Any) {
        url = newsArticlesVM.url
        self.performSegue(withIdentifier: "toWebView", sender: nil)
       
    }
    @objc func shareURL() {
        let url = [URL(string: newsArticlesVM.url)!]
        let ac = UIActivityViewController(activityItems: url, applicationActivities: nil)
        present(ac, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            let destinationVC = segue.destination as! WebViewController
            destinationVC.newsUrl = url
       }
    }
    @objc func addFavourite(){
        //CoreDataya haberi kaydettim.
        Database().saveNews(newsData: newsArticlesVM)
        print("Fonksiyon ??al????acak")
    }
}
