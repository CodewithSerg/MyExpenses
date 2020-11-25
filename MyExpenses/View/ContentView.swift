//
//  ContentView.swift
//  MyExpenses
//
//  Created by Sergey Antoniuk on 11/25/20.
//
import Foundation
import SwiftUI

struct ContentView: View {
    
    //для перехода на AddView  с пом sheet листа
    @State private var showingAddExpens = false
    
   //свифт наблюдает за классом expenses и когда published
   // свойство items меняется обновляет все view
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
    //модификатор удаленя строчки
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Мои расходы")
            .navigationBarItems(trailing:
                                    Button(action: {
    // создаем тестовый экземпляр и добавляем его в массив:(затем заменим AddView)
    //  let expense = ExpenseItem(id: <#T##UUID#>, name: "Test", type: "", amount: 100)
    //  self.expenses.items.append(expense)
                                        self.showingAddExpens = true
                                        
                                    })
                                    {
                                        Image(systemName: "plus")
                                    }
    // переход на AddView
            ).sheet(isPresented: $showingAddExpens) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    //используем в onDelete  для удаления строчки
    func removeItems(as offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
