//
//  GlobalKeys.swift
//  Cell
//
//  Created by Noah on 2021/8/7.
//

import CoreData

extension Soul {
    
    static var awakedFilter: NSFetchRequest<Soul> {
        let ruler = NSPredicate.init(format: "awake == %d", true)
        let request = pureRequest
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        return request
    }
    
    static var awakedSoul: Soul? {
        get { finder(awakedFilter, viewContext: Memory.coreBag).first }
        set {
            awakedSoul?.awake = false
            newValue?.awake = true
            Memory.coreBag.sync()
        }
    }
}

extension Cell {
    
    static func alivedFilter(of soul: Soul?) -> NSFetchRequest<Cell> {
        
        guard let soulId = soul?.soulId else {
            return emptyRequest
        }
        
        let request = pureRequest
        let ruler = NSPredicate.init(format: "soul.soulId == %@ AND alive == %d", soulId, true)
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        return request
    }
    
    static func alivedCells(of soul: Soul?) -> [Cell] {
        finder(alivedFilter(of: soul), viewContext: Memory.coreBag)
    }
    
    static var alivedCell: Cell? {
        get { alivedCells(of: Soul.awakedSoul).first }
        set {
            guard let cells = newValue?.soul?.cells else { return }
            cells.forEach { value in
                guard let cell = value as? Cell else { return }
                cell.alive = cell.cellId == newValue?.cellId
            }
            Memory.coreBag.sync()
        }
    }
    
    func frozen() {
        alive = false
        Memory.coreBag.sync()
    }
}

extension Chat {
    
    static func relatedFilter(of cell: Cell?) -> NSFetchRequest<Chat> {
        
        guard let cellId = cell?.cellId else {
            return emptyRequest
        }
        
        let request = pureRequest
        //正则
        let ruler = NSPredicate.init(format: "cellId == %@", cellId)
        request.predicate = ruler
        //取出全部内容
        request.returnsObjectsAsFaults = false
        //批处理
        request.fetchBatchSize = 20
        //分页
        request.fetchOffset = 0
        request.fetchLimit = 20
        //排序
        request.sortDescriptors = [.init(key: "lastMsgSentDate", ascending: false)]
        
        return request
    }
    
    static func relatedChats(of cell: Cell?, in bag: NSManagedObjectContext) -> [Chat] {
        guard cell?.cellId != nil else {
            return []
        }
        return finder(relatedFilter(of: cell), viewContext: bag)
    }
}

extension Message {
    
    static func relatedFilter(of chat: Chat?, fetch offset: Int = 0, _ limit: Int = 20) -> NSFetchRequest<Message> {
                
        guard let chatId = chat?.chatId else {
            return emptyRequest
        }
        
        let request = pureRequest
        //正则
        let ruler = NSPredicate.init(format: "chatId == %@", chatId)
        request.predicate = ruler
        //取出全部内容
        request.returnsObjectsAsFaults = false
        //批处理
        request.fetchBatchSize = 50
        //分页
        request.fetchOffset = offset
        request.fetchLimit = limit
        //排序
        request.sortDescriptors = [.init(key: "lastMsgSentDate", ascending: false)]
        
        return request
    }
        
    static func messages(of chat: Chat?, fetch offset: Int = 0, _ limit: Int = 20, in bag: NSManagedObjectContext) -> [Message] {
        guard chat?.chatId == nil  else {
            return []
        }
        return finder(relatedFilter(of: chat, fetch: offset, limit), viewContext: bag)
    }
}

//MARK: 默认查找器
protocol SilkBagCatcher: NSManagedObject {
    
}

extension SilkBagCatcher {
    //MARK: 无条件请求
    static var pureRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entity().managedObjectClassName)
        request.sortDescriptors = []
        return request
    }
    
    //MARK: 空请求
    static var emptyRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entity().managedObjectClassName)
        request.predicate = NSPredicate.init(format: "1=0")
        return request
    }
    
    //MARK: 查找数据
    static func finder(_ request: NSFetchRequest<Self>, viewContext: NSManagedObjectContext) -> [Self] {
        
        do {
            return try viewContext.fetch(request)
        } catch {
            let nsError = error as NSError
            let errorLog = "error coredata find \(nsError), \(nsError.userInfo)"
            CLog(errorLog, kill: true)
        }
        return []
    }
}
