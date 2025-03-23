//
//  APIHandler.swift
//  USNewsAPP
//
//  Created by Swapna Mutchu on 23/03/25.
//

import Foundation

class APIHandler {
    
    func makeAPICall(completionHandler: @escaping (NewsModel?) -> Void) {
        
        let apiKey = ""
        let urlString = String(format: newsBaseURL + "&apiKey=%@", apiKey)
       
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let responseData = data, error == nil else {
                completionHandler(nil)
                return
            }
            
            let result = try? JSONDecoder().decode(NewsModel.self, from: responseData)
            print(result!)
            
            guard let newsResult = result else {
                return
            }
            completionHandler(newsResult)
            
        }.resume()
    }
    
    func getLikes(articleID: String, completion: @escaping (Likes?) -> Void) {
        let urlString = "https://cn-news-info-api.herokuapp.com/likes/\(articleID)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let likes = try? JSONDecoder().decode(Likes.self, from: data)
            completion(likes)
        }.resume()
    }
    
    func getComments(articleID: String, completion: @escaping (Comments?) -> Void) {
        let urlString = "https://cn-news-info-api.herokuapp.com/comments/\(articleID)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let comments = try? JSONDecoder().decode(Comments.self, from: data)
            completion(comments)
        }.resume()
    }
    
}
