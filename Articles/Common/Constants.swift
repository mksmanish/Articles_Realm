//
//  Constants.swift
//  GeeksAssigment
//
//  Created by manish on 23/07/21.
//

/// This class having all the constants present in the app including baseUrl
import Foundation

class Constants : NSObject {
    
    enum Indentifiers {
        static let NewsitemsTableViewCell = "NewsitemsTableViewCell"
    }
    
    enum Urls {
        static let ServiceUrl = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
    }
    
    enum dateformats {
        static let forDate = "yyyy-mm-dd HH:mm:ss"
        static let resultDate = "MMM d, yyyy"
        static let resultTime = "hh:mm a"
    }
    
    enum rowHeight {
        static let regularArticle = 200
    }
    
}
