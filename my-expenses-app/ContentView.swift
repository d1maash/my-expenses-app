//
//  ContentView.swift
//  my-expenses-app
//
//  Created by Динмуханбет Айжарыков on 04.08.2024.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
    }
}


struct ContentView: View {
    @State private var showingAddExpence = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    item in HStack {
                        VStack (alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount) KZT")
                    }
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
