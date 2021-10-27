//
//  AppState.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import SwiftDux

struct AppState: StateType, TodoListCollection {
    
    var todoLists: OrderedState<TodoList> = defaultTodoLists
    
    var selectedTodoListID: String?
    
    var id: String?
    
    var todos: [String: Todo] = defaultTodos
    
}


fileprivate let defaultTodos = [
    "3": Todo(id: "3", text: "Coffee"),
    "1": Todo(id: "1", text: "Eggs"),
    "2": Todo(id: "2", text: "Milk")
]
    .merging(Array(4...1000).reduce([String:Todo]()) {
        var todos = $0
        let id = String($1)
        todos[id] = Todo(id: id, text: "Todo number: \($1)")
        return todos
    }) { (_, new) in new }

fileprivate let defaultTodoLists = OrderedState(
  TodoList(
    id: "123",
    name: "Shopping List",
    newTodoText: "",
    todoIds: ["1", "2", "3"]
  ),
  TodoList(
    id: "123456",
    name: "Very Large Todo List",
    newTodoText: "",
    todoIds: Array(4...1000).map { String($0) }
  )

)
