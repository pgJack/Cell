//
//  CellApp.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI

@main
struct CellApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
