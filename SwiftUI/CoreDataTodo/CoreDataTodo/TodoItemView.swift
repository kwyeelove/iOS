//
//  TodoItemView.swift
//  CoreDataTodo
//
//  Created by Kiwon on 22/08/2019.
//  Copyright © 2019 kwyee. All rights reserved.
//

import SwiftUI

struct TodoItemView: View {
    var title: String = ""
    var createAt: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(createAt).font(.caption)
            }
        }
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView()
    }
}
