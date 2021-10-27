//
//  TodoList.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation

struct TodoList: StateType {
    
    var id: String
    
    var name: String
    
    var newTodoText: String
    
    var todoIds: [String]
}
