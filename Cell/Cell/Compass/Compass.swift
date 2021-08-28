//
//  Compass.swift
//  Cell
//
//  Created by Noah on 2021/8/27.
//

import UIKit

enum Compass: String {
    
    case entangle = "entangle"
            
    case homeAction = "home/<action>"
    enum HomeMap:String {
        case goBackHome = "goBackHome"
        case sidebarShow = "sidebarShow"
        case sidebarHidden = "sidebarHidden"
        case popoverShow = "popoverShow"
        case searchPush = "searchPush"
        case seizePush = "seizePush"
        
        var actionPath: String { oceanPrefix+"home/"+self.rawValue }
    }
    
    case settingAction = "setting/<action>"
    enum SettingMap:String {
        case myAccountEditPush = "myAccountEditPush"
        case myAccountPush = "myAccountPush"
        case chatSettingsPush = "chatSettingsPush"
        case notificationsPush = "notificationsPush"
        case privacyPush = "privacyPush"
        case contactUsPush = "contactUsPush"
        case aboutPush = "aboutPush"
        
        var actionPath: String { oceanPrefix+"setting/"+self.rawValue }
    }
    
    case alert = "alert"
    
    static let oceanPrefix = "Cell://"
    var oceanPath: String { Compass.oceanPrefix+self.rawValue }
}
