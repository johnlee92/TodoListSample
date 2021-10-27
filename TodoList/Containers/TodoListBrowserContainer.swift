//
//  TodoListBrowserView.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI
import SwiftDux
import Combine

struct TodoListBrowserContainer: ConnectableView {
    
    struct Props: Equatable {
        var todoLists: OrderedState<TodoList>
        @ActionBinding var selectedTodoListId: String?
        @ActionBinding var addNewTodoList: () -> ()
        @ActionBinding var moveTodoLists: (IndexSet, Int) -> ()
        @ActionBinding var removeTodoLists: (IndexSet) -> ()
        @ActionBinding var selectDefaultTodoList: () -> ()
    }
    
    func map(state: AppState, binder: ActionBinder) -> Props? {
        return Props(
            todoLists: state.todoLists,
            selectedTodoListId: binder.bind(state.selectedTodoListID) {
                TodoListCollecitonAction.selectTodoList(id: $0)
            },
            addNewTodoList: binder.bind(TodoListCollecitonAction.addNewTodoList),
            moveTodoLists: binder.bind {
                TodoListCollecitonAction.moveTodoLists(from: $0, to: $1)
            },
            removeTodoLists: binder.bind {
                TodoListCollecitonAction.removeTodoLists(at: $0)
            },
            selectDefaultTodoList: binder.bind {
                guard state.selectedTodoListID == nil else {
                    return nil
                }
                return TodoListCollecitonAction.selectTodoList(id: state.todoLists.first?.id)
            }
        )
    }
    
    func body(props: Props) -> some View {
        List {
            ForEach(props.todoLists) { todoList in
                self.row(todoList: todoList, selectedTodoListID: props.$selectedTodoListId)
            }
            .onMove(perform: props.moveTodoLists)
            .onDelete(perform: props.removeTodoLists)
        }
        .navigationBarTitle(Text("Todo Lists"))
        .navigationBarItems(
          leading: EditButton(),
          trailing: AddButton(onAdd: props.addNewTodoList)
        )
        .onAppear { props.selectDefaultTodoList() }
    }
    
    func row(todoList: TodoList, selectedTodoListID: Binding<String?>) -> some View {
        TodoListRow(
            todoList: todoList,
            selectedID: selectedTodoListID,
            destination: TodoListContainer(id: todoList.id)
        )
    }
}
