//
//  AddFoodView.swift
//  icalories
//
//  Created by Elegant Media on 2024-02-26.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var manageObjectContext
    //when we submit it will navigate to mainView
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories:Double = 0
    
    
   
    var body: some View {
        Form{
            Section{
                TextField("Food name ",text: $name)
                
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories , in:0...1000,step:10)
                }//VStack
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addFood(name: name, calories: calories, context:manageObjectContext)
                        dismiss()
                    }
                    Spacer()
                }//HStack
            }
            
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
