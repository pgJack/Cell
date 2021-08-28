//
//  Compass+Home.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import Foundation

extension Navigator {
    func equipHomeMap() {
        handle(Compass.Map.homeAction.oceanPath, Compass.handleHomeAction)
    }
}

extension Compass {
    fileprivate static var handleHomeAction: URLOpenHandlerFactory {
        { url, values, context in
            guard let home = ship?.viewControllers.first as? HomeViewController,
                  let action = url.urlValue?.lastPathComponent,
                  isNonnull(action) else {
                return false
            }
            
            switch Compass.Map.HomeMap.init(rawValue: action) {
            case .goBackHome:
                ship?.popToRootViewController(animated: true)
            case .sidebarShow:
                home.homeSidebar.show(true)
            case .sidebarHidden:
                home.homeSidebar.dismiss(true)
            case .popoverShow:
                CLog("popover show")
            case .searchPush:
                CLog("search push")
            case .publishPush:
                CLog("publish push")
            default:
                return false
            }
            return true
        }
    }
}
