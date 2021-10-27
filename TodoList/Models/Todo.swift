//
//  Todo.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation

protocol TodoCollection {
    
    var todos: [String: Todo] { get set }
}

struct Todo: StateType {
    
    var id: String
    
    var text: String
    
    var completed: Bool = false
}
