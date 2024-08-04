//
//  ContentView.swift
//  my-expenses-app
//
//  Created by Динмуханбет Айжарыков on 04.08.2024.
//

import SwiftUI


struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}


struct ContentView: View {
    @State private var showingAddExpence = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    item in Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("My expenses")
                .navigationBarItems(trailing:
                                        Button(action:
                                                {
                    self.showingAddExpence = true
                }) {
                    Image(systemName: "plus")
                }
                ).sheet(isPresented: $showingAddExpence, content: {
                    AddView(expenses: self.expenses)
                })
        }
      
    }
    func removeItems(as offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets )
    }
}


#Preview {
    ContentView()
}
