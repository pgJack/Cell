//
//  CellSkipper.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit
import CoreData

class CellSkipper {
    
    static let shared = CellSkipper()
    
    static func enterOcean(_ ocean: UIWindow?) {
        
        shared._coreBag = Memory.coreBag
        shared._coreScroll = Memory.coreScroll
        
        let key = Cell.alivedCell?.cellId?.md5
        
        shared._memory = Memory(scroll: key, bag: key, type: .silkBag)
        
        //MARK: Prepare Compass
        let root = key == nil ? LoginViewController() : HomeViewController()
        
        shared._ocean = ocean

        shared._ship = BaseNavigationController(rootViewController: root)
        shared._navigator = Navigator()
        
        shared._navigator?.equipBasicMap()
        shared._navigator?.equipHomeMap()
        shared._navigator?.equipSettingMap()
        
        shared._ocean?.backgroundColor = .dynamicColor(.white, .black)
        shared._ocean?.tintColor = .theme_white_dy
        shared._ocean?.rootViewController = shared._ship
    }
    
    //MARK: Compass
    private var _ocean: UIWindow?
    private var _ship: BaseNavigationController?
    private var _navigator: Navigator?
    
    static var ocean: UIWindow? { shared._ocean }
    static var ship: BaseNavigationController? { shared._ship }
    static var navigator: Navigator? { shared._navigator }

    //MARK: Memory
    private var _memory: Memory?
    private var _coreBag: NSManagedObjectContext?
    private var _coreScroll: UserDefaults?
    
    static var memory: Memory? { shared._memory }
    static var coreBag: NSManagedObjectContext? { shared._coreBag }
    static var coreScroll: UserDefaults? { shared._coreScroll }
}
