//
//  Utility.swift
//  GeeksAssigment
//
//  Created by manish on 23/07/21.
//

import Foundation
/// This class having all the common functionalities used in the project
class DateFunctions {
    
    static let sharedInstance = DateFunctions()
    // function to convert the date to required format from UTC 2021-07-23 07:02:36
    func getDateFromUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateformats.forDate
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let dt = dateFormatter.date(from: date) else { return "" }
        dateFormatter.timeZone =  TimeZone.current
        dateFormatter.dateFormat = Constants.dateformats.resultDate
        return dateFormatter.string(from: dt)
    }

    // function to convert the date to required format from UTC
    func getTimeFromUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateformats.forDate
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let dt = dateFormatter.date(from: date) else { return "" }
        dateFormatter.timeZone =  TimeZone.current
        dateFormatter.dateFormat = Constants.dateformats.resultTime
        return dateFormatter.string(from: dt)
    }
    
}
