//
//  Compass+Home.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit

extension Navigator {
    func equipHomeMap() {
        handle(Compass.homeAction.oceanPath, Compass.handleHomeAction)
    }
}

extension Compass {
    fileprivate static var handleHomeAction: URLOpenHandlerFactory {
        { url, values, context in
            guard let home = CellSkipper.mainDock?.viewControllers.first as? HomeViewController,
                  let action = url.urlValue?.lastPathComponent,
                  isNonnull(action) else {
                return false
            }
            
            switch Compass.HomeMap.init(rawValue: action) {
            case .sidebarShow:
                home.homeSidebar.show(true)
            case .sidebarHidden:
                home.homeSidebar.dismiss(true)
            case .popoverShow:
                CLog("popover show")
            case .searchPush:
                CellSkipper.navigator?.push(SearchViewController())
            case .seizePush:
                CellSkipper.navigator?.push(SeizeViewController())
            default:
                return false
            }
            return true
        }
    }
}
