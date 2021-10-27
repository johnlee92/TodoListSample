//
//  TodoListCollectionAction.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import Combine
import SwiftDux

enum TodoListCollecitonAction: Action {
    case selectTodoList(id: String?)
    case addTodoList(id: String, name: String)
    case removeTodoLists(at: IndexSet)
    case moveTodoLists(from: IndexSet, to: Int)
    case setName(id: String, name: String)
    case setNewTodoText(id: String, text: String)
    case addTodoID(id: String, todoID: String)
    case moveTodos(id: String, from: IndexSet, to: Int)
    case removeTodoIDs(id: String, at: IndexSet)
}

extension TodoListCollecitonAction {
    static func addNewTodoList() -> ActionPlan<TodoListCollection> {
        ActionPlan { _ in
            Just(UUID().uuidString).map { id -> Action in
                TodoListCollecitonAction.addTodoList(id: id, name: "") +
                TodoListCollecitonAction.selectTodoList(id: id)
            }
        }
    }
    
    static func addTodo(id: String, text: String) -> ActionPlan<TodoListCollection> {
        ActionPlan { _ in
            Just(UUID().uuidString).map { todoID -> Action in
                TodoListAction.addTodo(id: todoID, text: text) +
                TodoListCollecitonAction.addTodoID(id: id, todoID: todoID)
            }
        }
    }
    
    static func removeTodos(id: String, at indexSet: IndexSet) -> ActionPlan<TodoListCollection> {
        ActionPlan { store in
            Just(store.state.todoLists[id]?.todoIds ?? []).map { todoIDs -> Action in
                TodoListAction.removeTodos(ids: indexSet.map { todoIDs[$0] }) +
                TodoListCollecitonAction.removeTodoIDs(id: id, at: indexSet)
            }
        }
    }
    
    static func toggleTodoCompletion(id: String, todoID: String, completed: Bool) -> ActionPlan<TodoListCollection> {
        ActionPlan { store in
            Just(store.state).compactMap { state -> Action? in
                guard let todoList = state.todoLists[id],
                      let todo = state.todos[todoID],
                      let index = todoList.todoIds.firstIndex(of: todo.id)
                else {
                    return nil
                }
                
                let lastNonCompletedIndex: Int = todoList.todoIds.lastIndex(where: {
                    state.todos[$0]?.completed == false
                }) ?? -1
                
                let newIndex = lastNonCompletedIndex > -1
                    ? lastNonCompletedIndex + 1
                    : (completed ? todoList.todoIds.count : 0)
                
                return TodoListAction.setCompleted(id: todoID, completed: completed)
                    + TodoListCollecitonAction.moveTodos(id: id, from: IndexSet([index]), to: newIndex)
            }
        }
    }
}
