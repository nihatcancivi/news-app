//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Nihat on 9.03.2022.
//

import Foundation

struct NewsArticlesViewModel {
    let newsArticles : NewsArticles
    
    
    init(_ articles : NewsArticles){
        self.newsArticles = articles
    }

    var author : String {
        return self.newsArticles.author ?? ""
    }
    var title : String {
        return self.newsArticles.title ?? ""
    }
    var description : String {
        return self.newsArticles.description ?? ""
    }
    var content : String {
        return self.newsArticles.content ?? ""
    }
    var publishedAt : String {
        return self.newsArticles.publishedAt ?? ""
    }
    var urlToImage : String {
        return self.newsArticles.urlToImage ?? ""
    }
    var url : String {
        return self.newsArticles.url ?? ""
    }
}

struct NewsArticlesListViewModel {
    let newsArticlesList : [NewsArticles]
    
}

extension NewsArticlesListViewModel{
    func numberOfRowsInSection() ->Int{
        return self.newsArticlesList.count
    }
    func newsAtIndex(_ index : Int)->NewsArticlesViewModel{
        let news = self.newsArticlesList[index]
        return NewsArticlesViewModel(news)

    }
}
