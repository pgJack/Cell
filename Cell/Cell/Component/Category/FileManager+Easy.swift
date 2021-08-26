//
//  FileManager+Logs.swift
//  umbrella
//
//  Created by Noah on 2021/8/9.
//  Copyright © 2021 Rongcloud. All rights reserved.
//

import Foundation

private let GroupID = "group.com.beem.im.dev"

// 获取沙盒地址
@objc
public extension FileManager {
    
    static var appSupportFolder: URL {
        .init(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!)
    }
    
    static var appCacheFolder: String {
        NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
    }
}
