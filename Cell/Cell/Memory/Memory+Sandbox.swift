//
//  Memory+Sandbox.swift
//  Cell
//
//  Created by Noah on 2021/8/21.
//

import CoreData

extension Memory {
        
    var silkbagTidy: Void { silkBag?.sync() }
        
    static func silkbagBoxURL(_ key: String) -> URL {
        let systemURL = FileManager.appSupportFolder
        let folderURL = systemURL.appendingPathComponent("Source")
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                let nsError = error as NSError
                CLog("error coredata create core \(nsError), \(nsError.userInfo)", kill: true)
            }
        }
        return folderURL.appendingPathComponent(key + ".sqlite")
    }
}

extension NSManagedObjectContext {
    //MARK: 实例化数据 & 刷新页面
    func sync() {
        do {
            try save()
        } catch {
            let nsError = error as NSError
            let errorLog = "error coredata sync \(nsError), \(nsError.userInfo)"
            CLog(errorLog, kill: true)
        }
    }
}

//MARK: 默认查找器
protocol MemoryCatcher: NSManagedObject {
    
    
}

extension MemoryCatcher {
    //MARK: 无条件请求
    static var pureRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entity().managedObjectClassName)
        request.sortDescriptors = []
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
