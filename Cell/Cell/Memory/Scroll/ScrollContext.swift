//
//  ScrollContext.swift
//  Cell
//
//  Created by Noah on 2021/8/26.
//

import UIKit

public struct ScrollContext {
    
    //主题样式
    private static let _appearenceKey = "cell_appearence"
    static var appearence: UIUserInterfaceStyle {
        set { Memory.coreScroll.set(newValue.rawValue, forKey: _appearenceKey) }
        get { UIUserInterfaceStyle(rawValue: Memory.coreScroll.integer(forKey: _appearenceKey)) ?? .light }
    }
    
    //系统语言
    static var language: [String]? { UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] }
}
