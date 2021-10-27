//
//  TodoListReducer.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import SwiftDux

struct TodoListReducer<State>: Reducer where State: TodoCollection {
    
    func reduce(state: State, action: TodoListAction) -> State {
        var state = state
        switch action {
            case let .addTodo(id, text):
                state.todos[id] = Todo(id: id, text: text)
            case let .setText(id, text):
                state.todos[id] = updateTodo(todo: state.todos[id]) {
                    $0.text = text
                }
            case let .setCompleted(id, completed):
                state.todos[id] = updateTodo(todo: state.todos[id]) {
                    $0.completed = completed
                }
            case let .removeTodos(ids):
                ids.forEach { state.todos.removeValue(forKey: $0) }
        }
        return state
    }
    
    func updateTodo(todo: Todo?, perform: (inout Todo) ->()) -> Todo? {
        guard var todo = todo else { return nil }
        perform(&todo)
        return todo
    }
}
