//
//  GlobalSetting.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit

//MARK: Voice Control
public var MuteStatus: Bool {
    get { ScrollContext.mute }
    set { ScrollContext.mute = newValue }
}

//MARK: Appearence
public var SkinStyle: UIUserInterfaceStyle {
    get {
        let stype = ScrollContext.appearence
        if let currentStyle = Compass.ocean?.overrideUserInterfaceStyle,
           currentStyle != stype {
            Compass.ocean?.overrideUserInterfaceStyle = stype
        }
        return stype
    }
    set {
        ScrollContext.appearence = newValue
        Compass.ocean?.overrideUserInterfaceStyle = newValue
    }
}
