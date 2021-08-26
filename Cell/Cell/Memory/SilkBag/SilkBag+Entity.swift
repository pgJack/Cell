//
//  SourceTool.swift
//  Cell
//
//  Created by Noah on 2021/8/7.
//

import CoreData

//MARK: 神
extension Soul: SilkBagCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext,
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
extension Cell: SilkBagCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext,
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
extension Chat: SilkBagCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext,
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
extension Message: SilkBagCatcher {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext,
                     mid: String,
                     type: Int16,
                     ownerId: String,
                     sentTime: TimeInterval,
                     of chat: Chat) {
        self.init(context: viewContext)
        msgId = mid
        msgType = type
        msgOwnerId = ownerId
        msgSentDate = Date(timeIntervalSince1970: sentTime)
        chatId = chat.chatId
        chatType = chat.chatType
    }
}
