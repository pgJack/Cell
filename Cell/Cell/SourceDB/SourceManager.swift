//
//  Persistence.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import CoreData

struct SourceManager {
    
    static let shared: SourceManager = SourceManager(inMemory: true)
    
    //MARK: 数据源中心
    let container: NSPersistentCloudKitContainer
    static var viewContext: NSManagedObjectContext { shared.container.viewContext }
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Cell")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = SourceManager.sourceCoreURL
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nsError = error as NSError? {
                CLog("error coredata init \(nsError), \(nsError.userInfo)", kill: true)
            }
        })
    }
    
    static var sourceCoreURL: URL {
        let systemURL = SystemDirectory.applicationSupport
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
        return folderURL.appendingPathComponent("SourceCore.sqlite")
    }
    
    static func update() {
        viewContext.sync()
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
protocol SourceFinder: NSManagedObject {
    static var defaultSorter: [NSSortDescriptor] { get }
    static var defaultFilter: NSPredicate? { get }
}
extension SourceFinder {
    
    //MARK: 默认排序
    static var defaultSorter: [NSSortDescriptor] { [] }
    
    //MARK: 默认过滤器
    static var defaultFilter: NSPredicate? { nil }
    //MARK: 空数据过滤器
    static var emptyFilter: NSPredicate { .init(format: "1 == 0") }
        
    //MARK: 无条件请求
    static var pureRequest:NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: entity().managedObjectClassName)
    }
    //MARK: 默认请求
    static var defaultRequest: NSFetchRequest<Self> {
        let request = pureRequest
        request.sortDescriptors = defaultSorter
        request.predicate = defaultFilter
        return request
    }
    
    //MARK: 默认上下文
    static var defaultContext:NSManagedObjectContext {
        SourceManager.viewContext
    }
    
    //MARK: 查找单一数据
    static func singleFinder(_ request: NSFetchRequest<Self> = defaultRequest) -> Self? {
        request.fetchLimit = 1
        return finder(request).first
    }
    
    //MARK: 查找数据
    static func finder(_ request: NSFetchRequest<Self> = defaultRequest, viewContext: NSManagedObjectContext = defaultContext) -> [Self] {
        
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

