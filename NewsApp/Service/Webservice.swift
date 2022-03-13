//
//  Webservice.swift
//  NewsApp
//
//  Created by Nihat on 9.03.2022.
//

import Foundation

class Webservice {
    func downloadNews(url : URL , completion : @escaping ([NewsArticles]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
                let newsList = try? JSONDecoder().decode(News.self, from: data)
                if let newsList = newsList?.articles {
                    completion(newsList)//verileri çektikten sonra haber detaylarını döndürüyorum.
                }
            }
        }.resume()
    }
}
