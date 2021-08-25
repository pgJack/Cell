//
//  Object+JSON.swift
//  umbrella
//
//  Created by Noah on 2021/4/8.
//  Copyright © 2021 Rongcloud. All rights reserved.
//

import Foundation
//import SwiftyJSON

//@objc
//extension NSObject {
//    func json() -> String? {
//        switch self {
//        case let dictionary as [String: Any]:
//            return dictionary.json()
//        case let array as [Any]:
//            return array.json()
//        case let string as String:
//            return string
//        default:
//            return nil
//        }
//    }
//}
//
//@objc
//extension NSString {
//    func jsonObject() -> [String: Any]? {
//        switch self {
//        case let string as String:
//            return string.jsonObject()
//        default:
//            return nil
//        }
//    }
//    func jsonArray() -> [Any]? {
//        switch self {
//        case let string as String:
//            return string.jsonArray()
//        default:
//            return nil
//        }
//    }
//}
//
//extension Array {
//    func json() -> String? {
//        JSON(self).rawString()
//    }
//}
//
//extension Dictionary {
//    func json() -> String? {
//        JSON(self).rawString()
//    }
//}
//
//extension String {
//    func jsonObject() -> [String: Any]? {
//        JSON(parseJSON: self).dictionaryObject
//    }
//    func jsonArray() -> [Any]? {
//        JSON(parseJSON: self).arrayObject
//    }
//}
