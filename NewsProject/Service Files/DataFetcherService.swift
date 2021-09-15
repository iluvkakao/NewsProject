//
//  File.swift
//  NewsProject
//
//  Created by Natallia Askerka on 25.08.21.
//

import Foundation

class DataFetcherService {
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }

    
    func getNews(completion: @escaping (NewsResponse?) -> Void) {
        let urlForNews = "https://newsapi.org/v2/top-headlines"
        let params: [String : String] = ["apiKey"  : "43c4da62a4c941bd96d549858469b6cb",
                                         "country" : "ru",
                                         "category": "business"]
        
        networkDataFetcher.genericJSONDataWith(type: .GET, urlString: urlForNews,
                                               parameters: params, response: completion)
    }
}
