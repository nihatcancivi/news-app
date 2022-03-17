//
//  FavouriteViewController.swift
//  NewsApp
//
//  Created by Nihat on 15.03.2022.
//

import UIKit

class FavouriteViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var newsList = [String]()
    var newsTitle : String?
    var deleteTitle  = ""

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //getData()
    }
    override func viewWillAppear(_ animated: Bool) {//sayfa görüneceği zaman fetch edicez.
        getData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
        cell.textLabel?.text = newsList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deger = indexPath.row
            deleteTitle = newsList[indexPath.row]
            Database().deleteFavourite(deleteTitle: deleteTitle, indexNews: deger)
            getData()
            self.tableView.reloadData()
        }
    }
    
    func getData(){
        newsList.removeAll(keepingCapacity: false)
        Database().fetchFavouriteNews { newsArticles in
            if newsArticles != nil {
                self.newsTitle = newsArticles?.title
                self.newsList.append(self.newsTitle!)
                self.tableView.reloadData()
            }
        }
        
    }

}
