//
//  TodoListContainer.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI
import SwiftDux

struct TodoListContainer: ConnectableView {
    
    var id: String
    
    @SwiftUI.State private var animate: Bool = false
    
    struct Props: Equatable {
        var todoIDs: [String]
        @ActionBinding var name: String
        @ActionBinding var newTodoText: String
        @ActionBinding var onAddTodo: (String) -> Void
        @ActionBinding var moveTodoLists: (IndexSet, Int) -> Void
        @ActionBinding var removeTodoLists: (IndexSet) -> Void
        @ActionBinding var deselectTodoList: () -> Void
    }
    
    func map(state: AppState, binder: ActionBinder) -> Props? {
        guard let todoList = state.todoLists[id] else { return nil }
        return Props(
            todoIDs: todoList.todoIds,
            name: binder.bind(todoList.name) { TodoListCollecitonAction.setName(id: id, name: $0)},
            newTodoText: binder.bind(todoList.newTodoText) { TodoListCollecitonAction.setNewTodoText(id: id, text: $0)},
            onAddTodo: binder.bind { TodoListCollecitonAction.addTodo(id: id, text: $0)},
            moveTodoLists: binder.bind { TodoListCollecitonAction.moveTodos(id: id, from: $0, to: $1)},
            removeTodoLists: binder.bind { TodoListCollecitonAction.removeTodos(id: id, at: $0)},
            deselectTodoList: binder.bind { TodoListCollecitonAction.selectTodoList(id: nil) }
        )
    }
    
    func body(props: Props) -> some View {
        VStack {
            TodoListNameField(name: props.$name)
            
            NewTodoRow(text: props.$newTodoText, onAddTodo: props.onAddTodo)
                .padding()
            
            list(props: props)
        }
    }
    
    func list(props: Props) -> some View {
        List {
            ForEach(props.todoIDs, id: \.self) { todoID in
                TodoContainer(todoListID: id, todoID: todoID)
            }
            .onMove(perform: props.moveTodoLists)
            .onDelete(perform: props.removeTodoLists)
        }
        .animation(animate ? .default : nil)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            animate = true
          }
        }
    }
}

struct TodoListContainer_Previews: PreviewProvider {
    
    static var store: Store<AppState> {
        configureStore()
    }
    
    static var previews: some View {
        TodoListContainer(id: "123")
    }
}
