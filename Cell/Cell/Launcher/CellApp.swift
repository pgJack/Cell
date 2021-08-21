//
//  CellApp.swift
//  Cell
//
//  Created by Noah on 2021/8/2.
//

import SwiftUI

@main
struct CellApp: App {
    
    let silkbag = Memory.silkbag
    
    var body: some Scene {
        WindowGroup {
            LauncherView().environment(\.managedObjectContext, silkbag)
        }
    }
}
