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
    case search, more, meetsSettings
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
    
    static var messages: HomeTab {
        HomeTab(icon: UIImage(named: "tab_message_normal"),
                seletedIcon: UIImage(named: "tab_message_selected"),
                name: Translate("Messages"),
                controller: BaseViewController(),
                rightItemTypes: (.search, .more))
    }
    
    static var meets: HomeTab {
        HomeTab(icon: UIImage(named: "tab_work_normal"),
                seletedIcon: UIImage(named: "tab_work_selected"),
                name: Translate("Meets"),
                controller: BaseViewController(),
                rightItemTypes: (nil, .meetsSettings))
    }
    
    static var contacts: HomeTab {
        HomeTab(icon: UIImage(named: "tab_contacts_normal"),
                seletedIcon: UIImage(named: "tab_contacts_selected"),
                name: Translate("Contacts"),
                controller: BaseViewController(),
                rightItemTypes: (.search, .more))
    }
}

//MARK: Sidebar Action
let kSidebarCellID = "side_bar_cell"

struct HomeSidebarAction {
    
    let name: String
    let icon: UIImage?
    
    static var chatActions: [HomeSidebarAction] {
        [HomeSidebarAction(name: Translate("My Account"), icon: UIImage.init(named: "profile_account_icon")),
         HomeSidebarAction(name: Translate("Chat Settings"), icon: UIImage.init(named: "profile_chat_icon")),
         HomeSidebarAction(name: Translate("Notifications"), icon: UIImage.init(named: "profile_noti_icon")),
         HomeSidebarAction(name: Translate("Privacy"), icon: UIImage.init(named: "profile_privacy_icon")),
         HomeSidebarAction(name: Translate("Contact Us"), icon: UIImage.init(named: "profile_feedback_icon")),
         HomeSidebarAction(name: Translate("About"), icon: UIImage.init(named: "profile_about_icon"))]
    }
}
