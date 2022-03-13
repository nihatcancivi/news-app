//
//  ViewController.swift
//  NewsApp
//
//  Created by Nihat on 8.03.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate {
    
    private var newsArticlesListVM : NewsArticlesListViewModel!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //Herhangi bir alana tıklanılmasını algılamak için view e recognizer verdim.Tıklanıldığında hideKeyboard çalışacak.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        getData()
    }
    func getData(){//tüm verileri API den çeker
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
        cell.newsDescriptionLabel.text = newsViewModel.description
        cell.newsImageView.kf.indicatorType = .activity
        cell.newsImageView.kf.setImage(with: URL(string: newsViewModel.urlToImage),placeholder: UIImage(named: "placeHolder"))
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {//searchbardaki kelime silinince klavye gizlenir ve tüm verileri getiriyorum.
        if searchBar.text == "" {
            getData()
            self.searchBar.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {//search buttonuna basıldığında aranan kelimenin API içerisinde varsa verilerini çeker.
        if let text = searchBar.text , !text.isEmpty {
            let urlString = "https://newsapi.org/v2/top-headlines?country=tr&q=\(text)&apiKey=5cd8e19306684af59e9d3c46271c76fe"
            if let queryString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){//türkçe karakter kullanmamıza izin verir yoksa arama yapmıyor.
                if let url = URL(string: queryString){
                    Webservice().downloadNews(url: url) { searchNews in
                        if let searchNews = searchNews {
                            self.newsArticlesListVM = NewsArticlesListViewModel(newsArticlesList: searchNews)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        searchBar.endEditing(true)//Klavyeden ara tuşuna basıldığında klavyeyi kapatıyorum.
    }
    @objc func hideKeyboard(){// boş bir alana tıklanıldığında klavye gizleme fonksiyonu
        view.endEditing(true)
    }
}
