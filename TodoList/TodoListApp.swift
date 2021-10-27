//
//  TodoListApp.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    var store = configureStore()
    
    var body: some Scene {
        WindowGroup {
            MainView(store: store)
        }
    }
}
