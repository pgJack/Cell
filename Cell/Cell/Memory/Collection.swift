//
//  SourceTool.swift
//  Cell
//
//  Created by Noah on 2021/8/7.
//

import CoreData

//MARK: 神
extension Soul: MemoryCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext = Memory.silkbag,
                     sid: String,
                     account: String,
                     code: String) {
        self.init(context: viewContext)
        soulId = sid
        soulAccount = account
        soulCode = code
    }
}

//MARK: 容
extension Cell: MemoryCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext =  Memory.silkbag,
                     cid: String,
                     spell: String,
                     of soul: Soul) {
        self.init(context: viewContext)
        self.soul = soul
        cellId = cid
        cellSpell = spell
    }
}

//MARK: 话
extension Chat: MemoryCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext =  Memory.silkbag,
                     cid: String,
                     type: Int16,
                     of cell: Cell) {
        self.init(context: viewContext)
        chatId = cid
        chatType = type
        cellId = cell.cellId
    }
}

//MARK: 讯
extension Message: MemoryCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext =  Memory.silkbag,
                     mid: String,
                     type: Int16,
                     ownerId: String,
                     sentTime: TimeInterval,
                     of chat: Chat?,
                     or chatId: String?,
                     with chatType: Int16) {
        self.init(context: viewContext)
        msgId = mid
        msgType = type
        msgOwnerId = ownerId
        msgSentDate = Date(timeIntervalSince1970: sentTime)
        
        guard let tChat = chat else {
            let newChat = Chat.init(viewContext, cid: chatId ?? UUID().uuidString, type: chatType, of: Memory.alivedCell!)
            self.chatId = newChat.chatId
            self.chatType = newChat.chatType
            return
        }
        
        self.chatId = tChat.chatId
        self.chatType = tChat.chatType
    }
    
    static var defaultSorter: [NSSortDescriptor] {
        [.init(key: "msgSentDate", ascending: true)]
    }
}
