//
//  Compass+Home.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import Foundation

extension Navigator {
    func equipSettingMap() {
        handle(Compass.settingAction.oceanPath, Compass.handleSettingAction)
    }
}

extension Compass {
    fileprivate static var handleSettingAction: URLOpenHandlerFactory {
        { url, values, context in
            guard let action = url.urlValue?.lastPathComponent,
                  isNonnull(action) else {
                return false
            }
            
            switch Compass.SettingMap.init(rawValue: action) {
            case .myAccountEditPush:
                CellSkipper.navigator?.push(MyAccountEditViewController())
            case .myAccountPush:
                CellSkipper.navigator?.push(MyAccountViewController())
            case .chatSettingsPush:
                CellSkipper.navigator?.push(ChatSettingsViewController())
            case .notificationsPush:
                CellSkipper.navigator?.push(NotificationsViewController())
            case .privacyPush:
                CellSkipper.navigator?.push(PrivacyViewController())
            case .contactUsPush:
                CellSkipper.navigator?.push(ContactUsViewController())
            case .aboutPush:
                CellSkipper.navigator?.push(AboutViewController())
            default:
                return false
            }
            return true
        }
    }
}
