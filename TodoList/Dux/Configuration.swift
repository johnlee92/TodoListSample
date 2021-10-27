//
//  configureStore.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import Foundation
import SwiftDux
import SwiftDuxExtras

func configureStore() -> Store<AppState> {
    
    Store(state: AppState(),
          reducer: TodoListCollectionReducer() + TodoListReducer(),
          middleware: PersistStateMiddleware(JSONStatePersistor())
    )
}
