//
//  LoginView.swift
//  Cell
//
//  Created by Noah on 2021/8/21.
//

import SwiftUI

struct LoginView: View {
        
    @State var showAlert = false
        
    var body: some View {
        
        Button(action: create) {
            Label("Create", systemImage: "plus")
        }
        .padding()
        .background(Color(.tertiarySystemFill))
        .cornerRadius(5)
        
        Button(action: login) {
            Label("Login", systemImage: "plus")
        }
        .padding()
        .background(Color(.tertiarySystemFill))
        .cornerRadius(5)
        
        if showAlert {
            Text("Create First")
        }
    }
    
    func create() {
        showAlert = false
        
        let soulId = UUID().uuidString
        let soul = Soul(sid: soulId, account: "Noah", code: "123")
                
        Memory.awakedSoul = soul
        Memory.silkbagTidy
    }
    
    func login() {
        
        guard let tSoul = Memory.awakedSoul else {
            showAlert = true
            return
        }
        
        let cell = Cell(cid: "\(tSoul.cells?.count ?? -1)", spell: "123", of: tSoul)
        Memory.alivedCell = cell
        Memory.silkbagTidy
    }
}
