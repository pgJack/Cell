//
//  ChatList.swift
//  Cell
//
//  Created by Noah on 2021/8/21.
//

import SwiftUI
import CoreData

struct ChatList: View {
        
    @Environment(\.managedObjectContext)
    private var viewContext: NSManagedObjectContext
    
    let request = FetchRequest(fetchRequest: Memory.chatsRequest(of: Memory.alivedCell))
    
    var body: some View {
        List {
            ForEach(request.wrappedValue) { chat in
                Text("Chat \(chat.name ?? ""))")
            }
            .onDelete(perform: deleteChats)
        }
    }
    
    private func deleteChats(offsets: IndexSet) {
        withAnimation {
            offsets.map { Memory.chats(of: Memory.alivedCell)[$0] }.forEach(viewContext.delete)
            Memory.silkbagTidy
        }
    }
}

private let chatDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
