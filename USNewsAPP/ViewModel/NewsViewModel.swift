//
//  NewsViewModel.swift
//  USNewsAPP
//
//  Created by Swapna Mutchu on 23/03/25.
//

import Foundation

class NewsViewModel {
    
    let apiHandler = APIHandler()
    var newsArticlesArray = [Articles]()
    
    func getLatestNewsAPI(completionHandler: @escaping () -> Void) {
        apiHandler.makeAPICall { result in
            guard let articles = result?.articles else {
                completionHandler()
                return
            }
            self.newsArticlesArray = articles
            completionHandler()
        }
    }
    
    func fetchLikes(articleID: String, completion: @escaping (Likes?) -> Void) {
        apiHandler.getLikes(articleID: articleID) { likes in
            completion(likes)
        }
    }
    
    func fetchComments(articleID: String, completion: @escaping (Comments?) -> Void) {
        apiHandler.getComments(articleID: articleID) { comments in
            completion(comments)
        }
    }
}
