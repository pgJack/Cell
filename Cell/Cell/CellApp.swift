//
//  CellApp.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI

@main
struct CellApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, SourceCenter.shared.container.viewContext)
        }
    }
}
