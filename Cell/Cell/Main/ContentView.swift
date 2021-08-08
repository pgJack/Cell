//
//  ContentView.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI
import CoreData

struct HomeView: View {
        
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Chat.defaultRequest)
    var chats1: FetchedResults<Chat>
    
    @State var chats:[Chat] = Chat.finder()

    var body: some View {
        NavigationView {
            
            List {
                ForEach(chats1) { chat in
                    Text("Chat \(chat.name ?? "") \n lastMessageTime \(itemFormatter.string(from: chat.lastMessage?.msgSentDate ?? Date()))")
                }.onDelete(perform: deleteChats)
            }
            
//            List(filter.wrappedValue, id: \.self) { chat in
//                Text("Chat \(chat.name ?? "") \n lastMessageTime \(itemFormatter.string(from: chat.lastMessage?.msgSentDate ?? Date()))")
//            }
//
//            FilterList(filter: filter) { chat in
//                Text("Chat \(chat.name ?? "") \n lastMessageTime \(itemFormatter.string(from: chat.lastMessage?.msgSentDate ?? Date()))")
//            }
//            .onDelete(perform: deleteChats)
            
//            List {
//                ForEach(chats) { chat in
//                    Text("Chat \(chat.name ?? "") \n lastMessageTime \(itemFormatter.string(from: chat.lastMessage?.msgSentDate ?? Date()))")
//                }
//                .onDelete(perform: deleteChats)
//            }
            .toolbar {
                Button(action: addChat) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .navigationBarTitle("Home")
        }.tabItem {
            Image(systemName: "leaf")
            Text("Home")
        }
    }
    
    private func addChat() {
        withAnimation {
            let chats = Chat.finder()
            let chatIndex = Int(arc4random_uniform(100))
            var chat: Chat?
            var login = false
            
            if chats.count > chatIndex {
                chat = chats[chatIndex]
            } else {
                
                if let cell = UserCenter.cell {
                    //存在cell
                    chat = Chat(cid: UUID().uuidString,
                                type: 0,
                                of: cell)
                } else if let soul = UserCenter.shared.soul {
                    //不存在cell 存在soul
                    let cell = Cell(cid: "\(soul.cells?.count ?? -1)",
                         spell: "123",
                         of: soul)
                    cell.alive = true
                    login = true
                    chat = Chat(cid: UUID().uuidString,
                                type: 0,
                                of: cell)
                } else {
                    //不存在cell 不存在soul
                    let soulId = UUID().uuidString
                    let soul = Soul(sid: soulId,
                                    account: "Noah",
                                    code: "123")
                    UserCenter.shared.soul = soul
                    let cell = Cell(cid: "\(soul.cells?.count ?? -1)",
                                    spell: "123",
                                    of: soul)
                    cell.alive = true
                    login = true
                    chat = Chat(cid: UUID().uuidString,
                                type: 0,
                                of: cell)
                }
            }
            
            let message = Message(mid: UUID().uuidString,
                    type: 0,
                    ownerId: UUID().uuidString,
                    sentTime: Date().timeIntervalSince1970,
                    of: chat!)
            
            if let tChat = chat {
                tChat.name = tChat.cellId
                tChat.lastMessage = message
                tChat.sortDate = message.msgSentDate
                SourceManager.update()
            }
            
//            if login {
//                filter = FetchRequest(fetchRequest: Chat.defaultRequest, animation: .default)
//            }
        }
    }
    
    private func deleteChats(offsets: IndexSet) {
        withAnimation {
//            offsets.map { chats[$0] }.forEach(viewContext.delete)
            SourceManager.update()
        }
    }
}

struct ContentView: View {
    
    let viewContext = SourceManager.shared.container.viewContext
    
    var body: some View {
        
        TabView {
            HomeView().environment(\.managedObjectContext, viewContext)            
            NavigationView {
                NavigationLink("Open the door",destination: Label("Add Item", systemImage: "plus"))
                    .navigationBarTitle("World")
            }.tabItem {
                Image(systemName: "wind")
                Text("World")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
