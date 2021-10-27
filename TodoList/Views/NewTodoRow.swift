//
//  NewTodoRow.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

struct NewTodoRow: View {
    
    @Binding var text: String
    
    var onAddTodo: (String) -> Void
    
    var body: some View {
        TextField("New todo", text: $text, onCommit: onEnter)
    }
    
    func onEnter() {
        onAddTodo(text)
        text = ""
    }
}
