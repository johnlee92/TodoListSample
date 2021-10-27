//
//  AddButton.swift
//  TodoList
//
//  Created by 이재현 on 2021/10/27.
//

import SwiftUI

public struct AddButton : View {
  public var onAdd: ()->()
  
  public var body: some View {
    Button(action: onAdd) {
      Image(systemName: "plus").imageScale(.large).padding()
    }
  }
}
