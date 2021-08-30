//
//  Persistence.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import CoreData

enum BagType: String {
    case silkBag = "SilkBag"
    case core = "Core"
}

struct Memory {
    
    init(scroll skey: String? = nil, bag bkey: String?, type: BagType = .silkBag) {
        
        _scrollKey = skey
        scroll = isNonnull(_scrollKey) ? UserDefaults(suiteName: _scrollKey) : nil

        _bagKey = bkey
        if let tBagKey = _bagKey,
           tBagKey.count > 0 {
            silkBagBox = NSPersistentContainer(name: type.rawValue)
            silkBagBox?.persistentStoreDescriptions.first?.url = Memory.silkbagBoxURL(tBagKey)
            silkBagBox?.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let nsError = error as NSError? {
                    CLog("error coredata init \(nsError), \(nsError.userInfo)", kill: true)
                }
            })
        } else {
            silkBagBox = nil
        }
    }
    
    //MARK: 卷轴
    private var _scrollKey: String?
    
    let scroll: UserDefaults?
    
    //MARK: 锦囊
    private var _bagKey: String?

    let silkBagBox: NSPersistentContainer?
    var silkBag: NSManagedObjectContext? { silkBagBox?.viewContext }
    
    //MARK: 核心
    private static let core = Memory(bag: "Core", type:.core)
    static var coreBag: NSManagedObjectContext { core.silkBag! }
    static var coreScroll: UserDefaults { .standard }
}

