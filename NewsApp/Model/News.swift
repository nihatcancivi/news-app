//
//  News.swift
//  NewsApp
//
//  Created by Nihat on 9.03.2022.
//

import Foundation

struct News : Decodable{
    var status : String
    var articles : [NewsArticles]
}





