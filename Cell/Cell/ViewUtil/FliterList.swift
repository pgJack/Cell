//
//  FliterList.swift
//  Cell
//
//  Created by Noah on 2021/8/8.
//

import SwiftUI
import CoreData

struct FilterList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // 这是我们的内容闭包；我们将为列表中的每个项目调用一次
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filter: FetchRequest<T>, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = filter
        self.content = content
    }
}

