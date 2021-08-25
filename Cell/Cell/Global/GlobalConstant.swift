//
//  GlobalConstant.swift
//  Cell
//
//  Created by Noah on 2021/8/8.
//

import UIKit

//MARK: Lay out
var kIsPad: Bool { UIDevice().userInterfaceIdiom == .pad }

var kScreenWidth: CGFloat { UIScreen.main.bounds.width }
var kScreenHeight: CGFloat { UIScreen.main.bounds.height }

var kNavigationBarHeight: CGFloat { 44 }
var kTabBarHeight: CGFloat { 49 }

//MARK: 日志
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
