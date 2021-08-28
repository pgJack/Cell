//
//  GlobalConstant.swift
//  Cell
//
//  Created by Noah on 2021/8/8.
//

import UIKit

//MARK: Common Color
public extension UIColor {

    class var theme: UIColor { white_FFDEAD }

    class var theme_black_dy: UIColor { dynamicColor(theme, black_1E1E1E) }
    class var theme_white_dy: UIColor { dynamicColor(theme, .white) }
    
    //白色
    class var white_FFDEAD: UIColor { 0x6495ED.color() }
    //黑色
    class var black_282828: UIColor { 0x282828.color() }
    class var black_1E1E1E: UIColor { 0x1E1E1E.color() }
    //灰色
    class var gray_DAE0E3: UIColor { 0xDAE0E3.color() }
    class var gray_8C959E: UIColor { 0x8C959E.color() }
    //紫色
    class var purple_7100FF: UIColor { 0x7100FF.color()}
    //蓝色
    class var blue_0A84FF: UIColor { 0x0A84FF.color()}
    //红色
    class var red_F03636: UIColor { 0xF03636.color() }
}

//MARK: Language
private let kDefaultLanguageCode = "zh-Hanz"

public var LanguageCode: String? { ScrollContext.language?.first ?? kDefaultLanguageCode }

public func Translate(_ key: String) -> String {
    NSLocalizedString(key, tableName: "Cell", comment: "")
}

//MARK: Lay out
var kIsPad: Bool { UIDevice().userInterfaceIdiom == .pad }

var kScreenWidth: CGFloat { UIScreen.main.bounds.width }
var kScreenHeight: CGFloat { UIScreen.main.bounds.height }

var kNavigationBarHeight: CGFloat { 44 }
var kTabBarHeight: CGFloat { 49 }
