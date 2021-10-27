//
//  TodoListRow.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

struct TodoListRow<Destination>: View where Destination: View {
    
    var todoList: TodoList
    
    @Binding var selectedID: String?
    
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination, tag: todoList.id, selection: $selectedID) {
            Text(todoList.name.isEmpty ? "Untitled todo list" : todoList.name)
        }
    }
}
