//
//  SourceTool.swift
//  Cell
//
//  Created by Noah on 2021/8/7.
//

import CoreData

//MARK: 里
extension Soul: SourceFinder {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext = defaultContext,
                     sid: String,
                     account: String,
                     code: String) {
        self.init(context: viewContext)
        soulId = sid
        soulAccount = account
        soulCode = code
    }
    
    static var defaultFilter: NSPredicate? {
        guard let soulId = UserDefaults.standard.string(forKey: kSoulIdKey) else {
            return emptyFilter
        }
        return .init(format: "soulId == %@", soulId)
    }
    
    var aliveCell: Cell? { cells?.filtered(using: Cell.defaultFilter!).first as? Cell }
}

//MARK: 表
extension Cell: SourceFinder {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext = defaultContext,
                     cid: String,
                     spell: String,
                     of soul: Soul) {
        self.init(context: viewContext)
        self.soul = soul
        cellId = cid
        cellSpell = spell
    }
    
    static var defaultFilter: NSPredicate? { .init(format: "alive == %d", true) }
}

//MARK: 会话
extension Chat: SourceFinder {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext = defaultContext,
                     cid: String,
                     type: Int16,
                     of cell: Cell) {
        self.init(context: viewContext)
        chatId = cid
        chatType = type
        cellId = cell.cellId
    }
    
    static var defaultFilter: NSPredicate? {
        return .init(format: "cellId == %@", UserCenter.cell?.cellId ?? "")
    }
    
    static var defaultSorter: [NSSortDescriptor] {        
        [.init(key: "sortDate", ascending: false)]
    }
}

//MARK: 消息
extension Message: SourceFinder {
    
    @discardableResult
    convenience init(_ viewContext: NSManagedObjectContext = defaultContext,
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
    }
}
