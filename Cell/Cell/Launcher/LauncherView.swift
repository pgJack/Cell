//
//  LauncherView.swift
//  Cell
//
//  Created by Noah on 2021/8/21.
//

import SwiftUI
import CoreData

struct LauncherView: View {
    
    @Environment(\.managedObjectContext)
    private var viewContext: NSManagedObjectContext
    
    let request = FetchRequest(fetchRequest: Memory.alivedCellRequest)
    var isLogined: Bool { request.wrappedValue.count > 0 }
    
    var body: some View {
        if isLogined {
            HomeView()
        } else {
            LoginView()
        }
    }
}
