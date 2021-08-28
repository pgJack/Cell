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
                CellSkipper.ship?.pushViewController(MyAccountEditViewController(), animated: true)
            case .myAccountPush:
                CellSkipper.ship?.pushViewController(MyAccountViewController(), animated: true)
            case .chatSettingsPush:
                CellSkipper.ship?.pushViewController(ChatSettingsViewController(), animated: true)
            case .notificationsPush:
                CellSkipper.ship?.pushViewController(NotificationsViewController(), animated: true)
            case .privacyPush:
                CellSkipper.ship?.pushViewController(PrivacyViewController(), animated: true)
            case .contactUsPush:
                CellSkipper.ship?.pushViewController(ContactUsViewController(), animated: true)
            case .aboutPush:
                CellSkipper.ship?.pushViewController(AboutViewController(), animated: true)
            default:
                return false
            }
            return true
        }
    }
}
