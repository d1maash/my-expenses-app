//
//  AddView.swift
//  my-expenses-app
//
//  Created by Динмуханбет Айжарыков on 04.08.2024.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    
    let types = ["Bussines", "Personal"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                }
            }
            TextField("Cost", text:$amount)
        }.navigationTitle("Add")
    }
}

#Preview {
    AddView(expenses: Expenses())
}
