//
//  MainModelClass.swift
//  ObserverNotification
//
//  Created by manish on 24/07/21.
//

import Foundation
import RealmSwift

// MARK: - Item
class MainModelClass : Object,Codable {
    
    @objc dynamic var title:String?
    @objc dynamic var link: String?
    @objc dynamic var author: String?
    @objc dynamic var thumbnail: String?
    @objc dynamic var itemDescription: String?
    @objc dynamic var content:String?
    @objc dynamic var pubDate:String?

}

// MARK: - Item
struct MainResponse: Decodable {
    let title: String
    let link: String
    let author: String
    let thumbnail: String
    let itemDescription, content: String
    let pubDate:String

    enum CodingKeys: String, CodingKey {
        case link, author, thumbnail
        case itemDescription 
        case title = "title"
        case content
        case pubDate
    }
}



