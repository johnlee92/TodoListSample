//
//  TodoContainer.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI
import SwiftDux

struct TodoContainer: ConnectableView {
    
    var todoListID: String
    var todoID: String
    
    struct Props: Equatable {
      @ActionBinding var text: String
      @ActionBinding var completed: Bool
    }
    
    func map(state: AppState, binder: ActionBinder) -> Props? {
      guard let todo = state.todos[todoID] else { return nil }
      return Props(
        text: binder.bind(todo.text) { TodoListAction.setText(id: todo.id, text: $0) },
        completed: binder.bind(todo.completed) {
            TodoListCollecitonAction.toggleTodoCompletion(
                id: self.todoListID,
                todoID: todo.id,
                completed: $0
            )
        }
      )
    }
    
    func body(props: Props) -> some View {
      TodoRow(completed: props.$completed, text: props.$text)
    }
}

public enum TodoListDetailsRowContainer_Previews: PreviewProvider {
  static var store: Store<AppState> {
    configureStore()
  }
  
  public static var previews: some View {
      TodoContainer(todoListID: "123", todoID: "2")
          .provideStore(store)
  }
}
