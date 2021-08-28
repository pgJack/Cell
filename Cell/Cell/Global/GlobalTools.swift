//
//  GlobalTools.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import Foundation

//MARK: Alert
func Alert(title: String, message: String, confirmText:String = Translate("OK")) {
    Compass.navigator?.open(Compass.Map.alert.oceanPath+"?title="+title+"&message="+message+"&confirm="+confirmText)
}

//MARK: Log
public func CLog(_ debug: Any, _ file: String = #file , _ function: String = #function, _ line: Int = #line, _ time: Date = Date(), kill: Bool = false) {
    #if DEBUG
    let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    let threadFlag = Thread.isMainThread ? "Main" : String.init(format: "%p", Thread.current)
    let log = "\(time) [\(threadFlag)] \(fileName):\(function) [\(line)] : \(debug)"
    if kill {
        fatalError(log)
    } else {
        print(log)
    }
    #endif
}
