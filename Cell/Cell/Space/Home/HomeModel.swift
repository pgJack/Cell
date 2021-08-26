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
enum HomeRightItemType {
    case search, more, publish
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
                controller: BaseViewController(),
                rightItemTypes: (.search, .more)),
        HomeTab(icon: UIImage(systemName: "map"),
                seletedIcon: UIImage(systemName: "map.fill"),
                name: Translate("World"),
                controller: BaseViewController(),
                rightItemTypes: (nil, .publish))]
    }
    
    static var workTab: [HomeTab] {
        []
    }
}

//MARK: Sidebar Action
let kSidebarCellID = "side_bar_cell"

struct HomeSidebarAction {
    
    let name: String
    let icon: UIImage?
    
    static var chatActions: [HomeSidebarAction] {
        let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight:.regular)
        return [HomeSidebarAction(name: Translate("My Account"), icon: UIImage.init(systemName: "person", withConfiguration: configuration)),
                HomeSidebarAction(name: Translate("Chat Settings"), icon: UIImage.init(systemName: "pencil.and.outline", withConfiguration: configuration)),
                HomeSidebarAction(name: Translate("Notifications"), icon: UIImage.init(systemName: "antenna.radiowaves.left.and.right", withConfiguration: configuration)),
                HomeSidebarAction(name: Translate("Privacy"), icon: UIImage.init(systemName: "lock", withConfiguration: configuration)),
                HomeSidebarAction(name: Translate("Contact Us"), icon: UIImage.init(systemName: "captions.bubble", withConfiguration: configuration)),
                HomeSidebarAction(name: Translate("About"), icon: UIImage.init(systemName: "info.circle", withConfiguration: configuration))]
    }
}
