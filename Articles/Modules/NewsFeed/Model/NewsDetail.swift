//
//  NewsDetail.swift
//  GeeksAssigment
//
//  Created by manish on 23/07/21.
//
/// This file is model for the news items.
import Foundation

// MARK: - NewsDetails
struct NewsDetails: Decodable {
    let status: String
    let feed: Feed
    let items: [Item]
}

// MARK: - Feed
struct Feed: Decodable {
    let url: String
    let title: String
    let link: String
    let author, feedDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case url, title, link, author
        case feedDescription = "description"
        case image
    }
}

// MARK: - Item
struct Item: Decodable {
    let title, pubDate: String
    let link, guid: String
    let author: String
    let thumbnail: String
    let itemDescription, content: String
    let enclosure: Enclosure
    let categories: [String]

    enum CodingKeys: String, CodingKey {
        case link, guid, author, thumbnail
        case itemDescription = "description"
        case title = "title"
        case pubDate = "pubDate"
        case content, enclosure, categories
    }
}

// MARK: - Enclosure
struct Enclosure: Decodable {
    let link: String?
    let type: String?
    let thumbnail: String?
}


