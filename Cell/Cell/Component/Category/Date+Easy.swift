//
//  Date+Easy.swift
//  umbrella
//
//  Created by Noah on 2021/4/8.
//  Copyright © 2021 Rongcloud. All rights reserved.
//


import Foundation

extension Date {
    
    public var timestamp: TimeInterval {
        timeIntervalSince1970
    }
    
    func string(_ type: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = type
        return formatter.string(from: self)
    }
    
    static func date(_ string:String, _ type: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = type
        return formatter.date(from: string)
    }
    
}
