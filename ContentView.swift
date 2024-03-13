//
//  ContentView.swift
//  icalories
//
//  Created by Elegant Media on 2024-02-22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    //get everthing by the date and order it in reverse
    @FetchRequest(sortDescriptors:[SortDescriptor(\.date , order:.reverse)]) var food:FetchedResults<Food>
    
    @State private var showingAddView = false
    
    
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
               Text("\(Int(totalCaloriesToday())) kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List{
                    ForEach(food){ food in
                        NavigationLink(destination:EditFoodView(food:food)){
                            HStack{
                                VStack(alignment: .leading,spacing: 6){
                                    Text(food.name!)
                                        .bold()
                                    Text("\(Int(food.calories))")+Text(" calories").foregroundColor(.red)
                                }//VStack
                                Spacer()
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                                
                            }//HStack
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }//VStack
            .navigationTitle("iCalories")
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    Button{
                        showingAddView.toggle()
                    } label:{
                        Label("Add Food" , systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented:$showingAddView){
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets:IndexSet){
        withAnimation{
            offsets.map{food[$0]}.forEach(managedObjectContext.delete)
                DataController().save(context:managedObjectContext)
            }
        }
    
    
    
    private func totalCaloriesToday() ->Double{
        
        var caloriesToday:Double = 0
        
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                caloriesToday += item.calories
            }
        }
        
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
