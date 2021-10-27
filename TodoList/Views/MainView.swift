//
//  ContentView.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI
import SwiftDux

typealias StateType = Equatable & Codable & Identifiable 

struct MainView: View {
    
    var store: Store<AppState>
    
    var body: some View {
        NavigationView {
            TodoListBrowserContainer()
        }
        .provideStore(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var store: Store<AppState> {
        configureStore()
    }
    
    static var previews: some View {
        MainView(store: store)
    }
}
