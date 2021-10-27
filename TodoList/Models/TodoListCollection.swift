//
//  TodoListCollection.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import SwiftDux

protocol TodoListCollection: TodoCollection {
    
    var todoLists: OrderedState<TodoList> { get set }
    
    var selectedTodoListID: String? { get set }
}
