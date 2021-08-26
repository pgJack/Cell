//
//  String+Regular.swift
//  umbrella
//
//  Created by Noah on 2021/4/7.
//  Copyright © 2021 Rongcloud. All rights reserved.
//

import Foundation
import CommonCrypto

public func isNull(_ object:Any?) -> Bool {
    switch object {
    case let object as String:
        return object.isEmpty
    case let object as [Any]:
        return object.isEmpty
    case let object as [String:Any]:
        return object.isEmpty
    default:
        return true
    }
}

public func isNonnull(_ object:Any?) -> Bool {
    !isNull(object)
}

extension String {
    public var md5: String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return hash as String
    }
}
