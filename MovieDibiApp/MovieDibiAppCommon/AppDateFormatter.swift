//
//  AppdateFormatter.swift
//  MovieDibiAppCommon
//
//  Created by Michał Pankowski on 31/01/2021.
//

public class AppDateFormatter {
    
    public static let shared = AppDateFormatter()
    
    private let dateFormatter = DateFormatter()
    
    public init() {
        dateFormatter.dateFormat = "yyyy"
    }
    
    public func date(from text: String,
                     withFormat format: String = "yyyy-MM-dd") -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: text)
    }
    
    public func string(from date: Date,
                       withFormat format: String = "yyyy") -> String? {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}
