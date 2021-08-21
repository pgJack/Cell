//
//  ContentView.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI

struct HomeView: View {
        
    let silkbag = Memory.silkbag
    
    var body: some View {
        
        TabView {
            NavigationView {
                ChatList()
                    .environment(\.managedObjectContext, silkbag)
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
            
            NavigationView {
                NavigationLink("Open the door",destination: Label("Add Item", systemImage: "plus"))
                    .navigationBarTitle("World")
            }.tabItem {
                Image(systemName: "wind")
                Text("World")
            }
        }
    }
    
    
    private func addChat() {
        
        guard let cell = Memory.alivedCell  else {
            return
        }
        
        let chats = Memory.chats(of: cell)
        let chatIndex = Int(arc4random_uniform(10))
        var chat: Chat!
        
        if chats.count > chatIndex {
            chat = chats[chatIndex]
        } else {
            let chatId = UUID().uuidString
            chat = Chat(cid: chatId, type: 0, of: cell)
            chat.name = chatId
        }
        
        let message = Message(mid: UUID().uuidString,
                              type: 0,
                              ownerId: UUID().uuidString,
                              sentTime: Date().timeIntervalSince1970,
                              of: chat!)
        chat.lastMsgId = message.msgId
        chat.lastMsgSummary = message.summary
        chat.lastMsgSenderId = message.senderId
        chat.lastMsgSentDate = message.msgSentDate
        
        withAnimation {
            Memory.silkbagTidy
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
