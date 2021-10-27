//
//  TodoListNameField.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

import SwiftUI

struct TodoListNameField : View {
  @Binding var name: String
  
  var body: some View {
      TextField("Untitled todo list", text: $name)
          .font(.title)
          .padding()
  }
}
