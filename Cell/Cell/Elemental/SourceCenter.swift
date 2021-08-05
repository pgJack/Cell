//
//  Persistence.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import CoreData

extension Soul {
    func current() -> Soul? {
        SourceCenter.shared.find()?.first
    }
}

extension Cell {
    func current() -> Cell? {
        SourceCenter.shared.find()?.first
    }
}

struct SourceCenter {
    
    static let shared: SourceCenter = SourceCenter(inMemory: true)
        
//    let cell: Cell
//    let soul: Soul

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//
//        for _ in 0..<1000 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Cell")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

extension SourceCenter {
    
    func create(soul sid: String, account: String, code: String) -> Soul {
        let soul: Soul = create()
        soul.soulId = sid
        soul.soulCode = account
        soul.soulAccount = code
        return soul
    }
    
    func create(cell cid: String, spell: String, of soul: Soul) -> Cell {
        let cell: Cell = create()
        cell.cellId = cid
        cell.cellSpell = spell
        cell.soul = soul
        return cell
    }
    
    func create(message mid: String, type: Int16, ownerId: String, of chat: Chat) -> Message {
        let message: Message = create()
        message.msgId = mid
        message.msgType = type
        message.msgOwnerId = ownerId
        message.chat = chat
        return message
    }
    
    func create(chat cid: String, type: Int16, of cell: Cell) -> Chat {
        let chat: Chat = create()
        chat.chatId = cid
        chat.chatType = type
        chat.cell = cell
        return chat
    }
    
    func create<T: NSManagedObject>() -> T {
        T(context: container.viewContext)
    }
    
    func sync() {
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func find<T: NSManagedObject>() -> [T]? {
        do {
            return try SourceCenter.shared.container.viewContext.fetch(NSFetchRequest.init(entityName: T.entity().managedObjectClassName)) as? [T]
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
