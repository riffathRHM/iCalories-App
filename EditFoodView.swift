//
//  EditFoodView.swift
//  icalories
//
//  Created by Elegant Media on 2024-02-26.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var manageObjectContext
    //when we submit it will navigate to mainView
    @Environment(\.dismiss) var dismiss
    
    var food:FetchedResults<Food>.Element
    @State private var name = ""
    @State private var calories:Double = 0
    
    
    
    var body : some View{
        Form{
            Section{
                TextField("\(food.name!)",text : $name)
                    .onAppear{
                        name = food.name!
                        calories = food.calories
                    }
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories , in:0...1000,step: 10)
                }//VStack
                .padding()
                
                HStack{
                   Spacer()
                    Button("Submit"){
                        DataController().editFood(food: food, name: name, calories: calories, context:manageObjectContext)
                        dismiss()
                    }
                   Spacer()
                }//HStack
            }
        }
    }
    
}

