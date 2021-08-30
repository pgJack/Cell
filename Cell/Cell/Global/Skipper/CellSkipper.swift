//
//  CellSkipper.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class CellSkipper {
    
    static let shared = CellSkipper()
    
    static func enterOcean(_ ocean: UIWindow?) {
        
        shared._coreBag = Memory.coreBag
        shared._coreScroll = Memory.coreScroll
        
        //MARK: Prepare Info & Memory & Ocean
        
        let alivedCell = Cell.alivedCell
                
        shared.avatarRelay.accept(alivedCell?.iconUrl)
        shared.nameRelay.accept(alivedCell?.name)
        
        let key = alivedCell?.cellId?.md5

        shared._memory = Memory(scroll: key, bag: key, type: .silkBag)
        
        let root = key == nil ? LoginViewController() : HomeViewController()
        
        shared._ocean = ocean

        shared._dock = BaseNavigationController(rootViewController: root)
        shared._navigator = Navigator()
        
        shared._navigator?.equipBasicMap()
        shared._navigator?.equipHomeMap()
        shared._navigator?.equipSettingMap()
        
        shared._ocean?.backgroundColor = .dynamicColor(.white, .black)
        shared._ocean?.tintColor = .theme_white_dy
        shared._ocean?.rootViewController = shared._dock
    }
    
    //MARK: Compass
    private var _ocean: UIWindow?
    private var _dock: BaseNavigationController?
    private var _navigator: Navigator?
    
    static var ocean: UIWindow? { shared._ocean }
    static var mainDock: BaseNavigationController? { shared._dock }
    static var navigator: Navigator? { shared._navigator }

    //MARK: Memory
    private var _memory: Memory?
    private var _coreBag: NSManagedObjectContext?
    private var _coreScroll: UserDefaults?
    
    static var memory: Memory? { shared._memory }
    static var coreBag: NSManagedObjectContext? { shared._coreBag }
    static var coreScroll: UserDefaults? { shared._coreScroll }
    
    //MARK: Bind Info
    private let nameRelay: BehaviorRelay<String?> = BehaviorRelay(value: "")
    static func bindNameView(_ view: UIView) {
        if let nameLabel = view as? UILabel {
            shared.nameRelay.asDriver().drive(nameLabel.rx.text).disposed(by: view.disposeBag)
        } else if let nameButton = view as? UIButton {
            shared.nameRelay.asDriver().drive(nameButton.rx.title(for: .normal)).disposed(by: view.disposeBag)
        }
    }
    
    private let avatarRelay = BehaviorRelay(value: URL(string: ""))
    static func bindAvatarView(_ view: UIView, pointSize: CGFloat = 32) {
        shared.avatarRelay.asDriver().drive(onNext: { iconUrl in
            
            let configuration = UIImage.SymbolConfiguration(pointSize: pointSize,
                                                            weight: .regular)
            let defaultIcon = UIImage(systemName: "person.crop.circle.fill",
                                      withConfiguration: configuration)
            
            if iconUrl != nil {
                if let iconView = view as? UIImageView {
                    iconView.kf.setImage(with: iconUrl, placeholder: defaultIcon)
                } else if let iconButton = view as? UIButton {
                    iconButton.kf.setImage(with: iconUrl, for: .normal, placeholder: defaultIcon)
                }
            } else {
                if let iconView = view as? UIImageView {
                    iconView.image = defaultIcon
                } else if let iconButton = view as? UIButton {
                    iconButton.setImage(defaultIcon, for: .normal)
                }
            }
        }).disposed(by: view.disposeBag)
    }
}
