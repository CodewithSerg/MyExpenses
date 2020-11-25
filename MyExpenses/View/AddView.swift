//
//  AddView.swift
//  MyExpenses
//
//  Created by Sergey Antoniuk on 11/25/20.
//

import SwiftUI

struct AddView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    //отслеживаем изменения и перерисовываем view, не инициализируем а только указываем тип
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    let types = ["Bussines", "Personal"]
    
    
    var body: some View {
        NavigationView{
            Form{
                TextField("name", text: $name)
                Picker("type", selection: $type){
                    ForEach(self.types, id:\.self){
                        Text($0)
                    }
                }
                
                TextField("стоимость", text: $amount)
                    .keyboardType(.numberPad)// только цифры
            }
            
            .navigationBarTitle("Добавить")
           
            // Сохранить строку через кнопку
            .navigationBarItems(trailing: Button("Сохранить"){
            //проверка на число без букв
                if let actualAmount = Int(self.amount){
                let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
            //добавили в массив
                    self.expenses.items.append(item)
            //addview исчезает после нажатия Сохранить
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
