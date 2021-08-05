//
//  ContentView.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI
import CoreData

struct ContentView: View {
        
    @Environment(\.managedObjectContext) private var viewContext
    
//    static func getAllNotes() -> NSFetchRequest<Chat> {
//        let request: NSFetchRequest<Chat> =
//        request.predicate = NSPredicate(format: "cellId = %d", )
//        request.sortDescriptors = []
//        return request
//    }
    
    @FetchRequest(fetchRequest: Chat.fetchRequest())
    private var chats: FetchedResults<Chat>
//
    var body: some View {
        
//        TabView {
//            NavigationView {
//                NavigationLink("切换的详细界面",destination: Text("这是个详细界面"))
//                    .navigationBarTitle("界面切换")
//            }
//            .tabItem {
//                Image(systemName: "star")
//                Text("One")
//            }
//
//            NavigationView {
//                NavigationLink("切换的详细界面",destination: Text("这是个详细界面"))
//                    .navigationBarTitle("界面切换")
//            }
//            .tabItem {
//                Image(systemName: "star.fill")
//                Text("Two")
//            }
//        }
//
        NavigationView {
            List {
                ForEach(chats) { chat in
                    Text("chat at \((chat.messages?.sortedArray(using: [NSSortDescriptor.init(key: "sentDate", ascending: false)]).first as? Message)?.summary ?? "--")")
                }
                .onDelete(perform: deleteChats)
            }.toolbar {
                #if os(iOS)
//                EditButton()
                #endif

                Button(action: addChat) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func addChat() {
        withAnimation {
            
//            let message = Message(context: viewContext)
//            message.msgId = UUID().uuidString
//            message.msgType = 0
//            message.msgOwnerId = SourceCenter.shared.cell.cellId
//
//            let chat = Chat(context: viewContext)
//            chat.chatId = UUID().uuidString
//            chat.chatType = 0
//            chat.messages = [message]
//            chat.cell = SourceCenter.shared.cell
//            print("create new Chat \(chat.chatId!) with Message \(message.msgId!)")
        
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteChats(offsets: IndexSet) {
        withAnimation {
            offsets.map { chats[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
