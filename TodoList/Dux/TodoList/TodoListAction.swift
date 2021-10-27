//
//  TodoListAction.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import SwiftDux

enum TodoListAction: Action {
    case setText(id: String, text: String)
    case setCompleted(id: String, completed: Bool)
    case addTodo(id: String, text: String)
    case removeTodos(ids: [String])
}
