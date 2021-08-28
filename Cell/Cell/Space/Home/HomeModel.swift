//
//  HomeModel.swift
//  Beem
//
//  Created by Noah on 2021/8/15.
//

import UIKit

//MARK: Type
enum HomeType {
    case chat, work
}

//MARK: Right Item Type
enum HomeRightItemType: String {
    case search = "magnifyingglass"
    case more = "ellipsis"
    case seize = "pencil.and.outline"
    
    var systemIcon: UIImage? { UIImage.init(systemName: self.rawValue, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight:.regular)) }
    var compassPath: String {
        
        switch self {
        case .search:
            return Compass.HomeMap.searchPush.actionPath
        case .more:
            return Compass.HomeMap.popoverShow.actionPath
        case .seize:
            return Compass.HomeMap.seizePush.actionPath
        }
    }
}

//MARK: Tab
struct HomeTab: Equatable {
    
    static func == (lhs: HomeTab, rhs: HomeTab) -> Bool {
        lhs.name == rhs.name
    }
    
    let icon: UIImage?
    let seletedIcon: UIImage?
    let name: String
    let controller: BaseViewController
    let rightItemTypes: (HomeRightItemType?, HomeRightItemType?)
    
    static var chatTab: [HomeTab] {
        [HomeTab(icon: UIImage(systemName: "house"),
                seletedIcon: UIImage(systemName: "house.fill"),
                name: Translate("Home"),
                controller: ChatListViewController(),
                rightItemTypes: (.search, .more)),
        HomeTab(icon: UIImage(systemName: "map"),
                seletedIcon: UIImage(systemName: "map.fill"),
                name: Translate("World"),
                controller: SkitterViewController(),
                rightItemTypes: (nil, .seize))]
    }
    
    static var workTab: [HomeTab] {
        []
    }
}

//MARK: Sidebar Action
struct HomeSidebarAction {
    
    let name: String
    let icon: UIImage?
    let tint: UIColor?
    let compassPath: String?
    
    static var chatActions: [HomeSidebarAction] {
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight:.regular)
        
        return [HomeSidebarAction(name: Translate("My Account"),
                                  icon: UIImage.init(systemName: "person", withConfiguration: configuration),
                                  tint: 0x7100FF.color(),
                                  compassPath: Compass.SettingMap.myAccountPush.actionPath),
                
                HomeSidebarAction(name: Translate("Chat Settings"),
                                  icon: UIImage.init(systemName: "pencil.and.outline", withConfiguration: configuration),
                                  tint: 0xFFA633.color(),
                                  compassPath: Compass.SettingMap.chatSettingsPush.actionPath),
                
                HomeSidebarAction(name: Translate("Notifications"),
                                  icon: UIImage.init(systemName: "antenna.radiowaves.left.and.right", withConfiguration: configuration),
                                  tint: 0xFC633F.color(),
                                  compassPath: Compass.SettingMap.notificationsPush.actionPath),
                
                HomeSidebarAction(name: Translate("Privacy"),
                                  icon: UIImage.init(systemName: "lock", withConfiguration: configuration),
                                  tint: 0x24BF71.color(),
                                  compassPath: Compass.SettingMap.privacyPush.actionPath),
                
                HomeSidebarAction(name: Translate("Contact Us"),
                                  icon: UIImage.init(systemName: "captions.bubble", withConfiguration: configuration),
                                  tint: 0xE846AD.color(),
                                  compassPath: Compass.SettingMap.contactUsPush.actionPath),
                
                HomeSidebarAction(name: Translate("About"),
                                  icon: UIImage.init(systemName: "info.circle", withConfiguration: configuration),
                                  tint: 0x3370FE.color(),
                                  compassPath: Compass.SettingMap.aboutPush.actionPath)]
    }
}
