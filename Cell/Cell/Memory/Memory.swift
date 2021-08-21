//
//  Persistence.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import CoreData

struct Memory {
    
    static let shared = Memory()
    
    //MARK: 卷轴
    static var scroll: UserDefaults { UserDefaults.standard }
    
    //MARK: 锦囊
    let silkbagBox: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Cell")
        container.persistentStoreDescriptions.first!.url = Memory.silkbagBoxURL
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nsError = error as NSError? {
                CLog("error coredata init \(nsError), \(nsError.userInfo)", kill: true)
            }
        })
        return container
    }()
    
    static var silkbag: NSManagedObjectContext { shared.silkbagBox.viewContext }
}

