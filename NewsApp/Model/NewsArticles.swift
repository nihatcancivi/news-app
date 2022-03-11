//
//  NewsArticles.swift
//  NewsApp
//
//  Created by Nihat on 9.03.2022.
//

import Foundation


struct NewsArticles : Decodable{
        var author : String?
        var description : String?
        var title : String?
        var urlToImage : String?
        var publishedAt : String?
        var content : String?
    
}
