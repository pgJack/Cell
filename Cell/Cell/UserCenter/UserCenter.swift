//
//  UserCenter.swift
//  Cell
//
//  Created by Noah on 2021/8/8.
//

import Foundation

class UserCenter {
    
    static let shared = UserCenter()
            
    var soul = Soul.singleFinder() {
        didSet {
            UserDefaults.standard.set(soul?.soulId, forKey: kSoulIdKey)
        }
    }
    
    static var cell: Cell? { shared.soul?.aliveCell }
}
