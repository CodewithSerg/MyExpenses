//
//  Expenses.swift
//  MyExpenses
//
//  Created by Sergey Antoniuk on 11/25/20.
//

import Foundation
import SwiftUI

//Класс для хранения массива затрат в одной переменной items

class Expenses: ObservableObject {
   
    // published - view наблюдает за свойством и если оно
    // поменялось то весь view обновляется
    @Published var items = [ExpenseItem](){
    
    // наблюдатель чтобы когда новая затрата добавляется мы могли читать эти изменения
        didSet {
    
    //закодируем данные в формат json + Userdefaults
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    // разахивируем данные после перезагрузки приложения из Userdefaults
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
    // присваиваем полученые данные масиву items иначе он будит пуст
                self.items = decoded
                return
            }
        }
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
