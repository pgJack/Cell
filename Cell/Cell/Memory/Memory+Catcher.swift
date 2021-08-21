//
//  GlobalKeys.swift
//  Cell
//
//  Created by Noah on 2021/8/7.
//

import CoreData

extension Memory {
    
    static var awakedSoulRequest: NSFetchRequest<Soul> {
        let ruler = NSPredicate.init(format: "awake == %d", true)
        let request = Soul.pureRequest
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        return request
    }
    
    static var awakedSoul: Soul? {
        get { Soul.finder(awakedSoulRequest).first }
        set {
            awakedSoul?.awake = false
            newValue?.awake = true
        }
    }
    
    static var alivedCellRequest: NSFetchRequest<Cell> {
        let ruler = NSPredicate.init(format: "soul.awake == %d AND alive == %d", true, true)
        let request = Cell.pureRequest
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        return request
    }
        
    static var alivedCell: Cell? {
        get { Cell.finder(alivedCellRequest).first }
        set {
            guard let cells = newValue?.soul?.cells else { return }
            
            cells.forEach { value in
                guard let cell = value as? Cell else { return }
                cell.alive = cell.cellId == newValue?.cellId
            }
        }
    }
}

extension Memory {
    
    static func chatsRequest(of cell: Cell?) -> NSFetchRequest<Chat> {
        let request = Chat.pureRequest
        
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
        request.fetchBatchSize = 50
        //排序
        request.sortDescriptors = [.init(key: "lastMsgSentDate", ascending: false)]
        
        return request
    }
    
    static func chats(of cell: Cell?) -> [Chat] {
        guard cell?.cellId != nil else {
            return []
        }
        return Chat.finder(chatsRequest(of: cell))
    }
    
    static func messages(of chat: Chat?, fetch offset: Int = 0, _ limit: Int = 20) -> [Message] {
        
        guard let chatId = chat?.chatId else {
            return []
        }
        
        let ruler = NSPredicate.init(format: "chatId == %@", chatId)
        let request = Message.pureRequest
        request.predicate = ruler
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 50
        request.fetchOffset = offset
        request.fetchLimit = limit
        return Message.finder(request)
    }
}
