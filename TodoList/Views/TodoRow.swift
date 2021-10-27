//
//  TodoRow.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

struct TodoRow : View {
  @Binding var completed: Bool
  @Binding var text: String
  
  var body: some View {
    HStack {
      Toggle(isOn: $completed) { EmptyView() }
        .toggleStyle(CheckedToggleStyle())
      TextField("Empty", text: $text)
    }
  }
}

struct CheckedToggleStyle : ToggleStyle {
  
  func makeBody(configuration: ToggleStyleConfiguration) -> some View {
    let color: Color = configuration.isOn ? .green : .secondary
    let iconName = configuration.isOn ? "checkmark.circle.fill" : "circle"
    return Button(action: { configuration.isOn = !configuration.isOn }) {
      Image(systemName: iconName)
        .imageScale(.large).padding()
        .foregroundColor(color)
    }
  }
}
