//
//  NewsModel.swift
//  USNewsAPP
//
//  Created by Swapna Mutchu on 23/03/25.
//

import Foundation

struct NewsModel: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
}

struct Articles: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let publishedAt: String?
    let url: String?
    let urlToImage: String?
}

struct Likes: Decodable {
    let numberOfLikes: Int?
}

struct Comments: Decodable {
    let numberOfComments: Int?
}
