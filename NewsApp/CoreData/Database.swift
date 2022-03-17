//
//  Database.swift
//  NewsApp
//
//  Created by Nihat on 14.03.2022.
//

import Foundation
import UIKit
import CoreData

class Database {
    var titleArray = [String]()
    var idArray = [UUID]()

    func saveNews(newsData : NewsArticlesViewModel){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let news = NSEntityDescription.insertNewObject(forEntityName: "NewsEntity", into: context)
        
        news.setValue(newsData.title, forKeyPath: "newsTitle")
        news.setValue(newsData.description, forKeyPath: "newsDescription")
        news.setValue(newsData.author, forKeyPath: "newsAuthor")
        news.setValue(newsData.publishedAt, forKeyPath: "newsDate")
        news.setValue(newsData.urlToImage, forKeyPath: "newsImageUrl")
        news.setValue(newsData.url, forKeyPath: "newsUrl")
        news.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("Haber başarılı şekilde dbye kaydedildi.")
            
        }catch{
            print("DB ye kayıt edilemedi.,")
        }
    }
    func fetchFavouriteNews(completion : @escaping (NewsArticles?) ->()){
        titleArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "newsTitle") as? String{
                        self.titleArray.append(title)
                        if let description = result.value(forKey: "newsDescription") as? String{
                            if let author = result.value(forKey: "newsAuthor") as? String{
                                if let date = result.value(forKey: "newsDate") as? String{
                                    if let imageUrl = result.value(forKey: "newsImageUrl") as? String{
                                        if let url = result.value(forKey: "newsUrl") as? String{
                                            if let id = result.value(forKey: "id") as? UUID{
                                                self.idArray.append(id)
                                                let data = NewsArticles(author: author, description: description, title: title, urlToImage: imageUrl, publishedAt: date, content: "", url: url)
                                                completion(data)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }catch{
            print("Veriler databaseden çekilemedi")
        }
        
    }
    func deleteFavourite(deleteTitle : String , indexNews : Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        fetchRequest.predicate = NSPredicate(format: "newsTitle = %@", deleteTitle)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let titlee = result.value(forKey: "newsTitle") as? String {
                        if titlee == deleteTitle {
                            context.delete(result)
                            do{
                                try context.save()
                            }catch{
                                print("Silme kaydedilemedi")
                            }
                            break
                        }
                    }
                }
            }
        }catch{
            print("Hata , silinemedi.")
        }
        
    }
}
