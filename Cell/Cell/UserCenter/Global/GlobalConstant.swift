//
//  GlobalConstant.swift
//  Cell
//
//  Created by Noah on 2021/8/8.
//

import Foundation

//MARK: 日志
public func CLog(_ debug: Any, _ file: String = #file , _ function: String = #function, _ line: Int = #line, _ time: Date = Date(), kill: Bool = false) {
    #if DEBUG
    let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    let log = "\(time) \(fileName):\(function):[\(line)] \(debug)"
    if kill {
        fatalError(log)
    } else {
        print(log)
    }
    #endif
}

//MARK: 路径
public struct SystemDirectory {
    
    static var applicationSupport: URL {
        .init(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!)
    }
}
