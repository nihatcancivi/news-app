//
//  ViewController.swift
//  NewsApp
//
//  Created by Nihat on 8.03.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    private var newsArticlesListVM : NewsArticlesListViewModel!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    
    func getData(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=5cd8e19306684af59e9d3c46271c76fe")!
        Webservice().downloadNews(url: url) { news in
            if let news = news {
                
                self.newsArticlesListVM = NewsArticlesListViewModel(newsArticlesList: news)
               
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArticlesListVM == nil ? 0 : self.newsArticlesListVM.numberOfRowsInSection()
   }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsViewCell
        let newsViewModel = self.newsArticlesListVM.newsAtIndex(indexPath.row)
        cell.newsTitleLabel.text = newsViewModel.title
        cell.newsImageView.kf.setImage(with: URL(string: newsViewModel.urlToImage),placeholder: UIImage(named: "placeHolder"))
        return cell
    }
}

