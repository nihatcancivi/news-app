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
    private var newsVM : NewsArticlesViewModel!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        navigationController?.navigationBar.prefersLargeTitles = true //büyük başlık
       
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
        self.newsVM = self.newsArticlesListVM.newsAtIndex(indexPath.row)
        cell.newsTitleLabel.text = self.newsVM.title
        cell.newsDescriptionLabel.text = self.newsVM.description
        cell.newsImageView.kf.indicatorType = .activity
        cell.newsImageView.kf.setImage(with: URL(string: self.newsVM.urlToImage),placeholder: UIImage(named: "placeHolder"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.newsVM = self.newsArticlesListVM.newsAtIndex(indexPath.row)
        print(newsVM.author)
        self.performSegue(withIdentifier: "toNewsDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsDetailsVC" {
            let destinationVC = segue.destination as! NewsDetailsViewController
            destinationVC.newsArticlesVM = self.newsVM//seçilen satırın modelini diğer sayfaya yolladım.
       }
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
}

