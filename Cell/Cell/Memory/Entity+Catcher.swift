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
        }
    }
}

extension Cell {
    
    static func alivedFilter(of soul: Soul?) -> NSFetchRequest<Cell> {
        
        let request = pureRequest

        guard let soulId = soul?.soulId else {
            request.fetchLimit = 0
            return request
        }
        
        let ruler = NSPredicate.init(format: "soul.soulId == %@ AND alive == %d", soulId, true)
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        return request
    }
    
    static func alivedCell(of soul: Soul?) -> Cell? {
        finder(alivedFilter(of: soul), viewContext: Memory.coreBag).first
    }
    
    static var alivedCell: Cell? {
        get { alivedCell(of: Soul.awakedSoul) }
        set {
            guard let cells = newValue?.soul?.cells else { return }
            cells.forEach { value in
                guard let cell = value as? Cell else { return }
                cell.alive = cell.cellId == newValue?.cellId
            }
        }
    }
}

extension Chat {
    
    static func relatedFilter(of cell: Cell?) -> NSFetchRequest<Chat> {
        let request = pureRequest
        
        guard let cellId = cell?.cellId else {
            request.fetchLimit = 0
            return request
        }
        
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
        
        let request = pureRequest
        
        guard let chatId = chat?.chatId else {
            request.fetchLimit = 0
            return request
        }
        
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
