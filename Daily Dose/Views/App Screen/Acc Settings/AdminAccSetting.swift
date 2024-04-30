//
//  AdminAccSetting.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/17/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AdminAccSetting: View {
    @EnvironmentObject var viewModel: AuthView
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    func signOut() async{
        await viewModel.signOut()
    }
    
    func deleteAccount() async{
        do{
            try await viewModel.deleteAccount()
        }catch{
            print("DEBUG:cannot delete account")
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    //Link to add bulk meals
                    NavigationLink {
                        AddBulkMealView()
                    } label: {
                        Text("Add to Bulk Meals")
                    }
                    //Link to add cut meals
                    NavigationLink {
                        AddCutMealView()
                    } label: {
                        Text("Add to Cut Meals")
                    }
                    //Link to add Workouts
                    NavigationLink {
                        addWorkoutView()
                    } label: {
                        Text("Add to Workouts")
                    }
                }
                VStack{
                    Text("Set your goal!")
                    HStack(spacing: 20){
                        //bulk option
                        Button{
                            Task{
                                try await viewModel.bulk()
                            }
                        }
                    label:{
                        Text("Bulk")
                            .padding()
                            .background(Color(mainColor).ignoresSafeArea().opacity(0.6))
                            .cornerRadius(100)
                            .foregroundColor(.black)
                    }
                        //cut option
                        Button{
                            Task{
                                try await viewModel.cut()
                            }
                        }
                    label:{
                        Text("Cut")
                            .padding()
                            .background(Color(mainColor).ignoresSafeArea().opacity(0.6))
                            .cornerRadius(100)
                            .foregroundColor(.black)
                        }
                    }
                }
                
            }.navigationTitle("Account Settings")
                .toolbar(content: {
                    ToolbarItemGroup {
                        Button(action: {
                            Task{
                                await signOut()
                            }
                        }, label: {
                            VStack {
                                Image(systemName: "arrow.right.to.line.compact")
                                    .foregroundColor(.black)
                                Text("Log Out")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.black)
                            }
                            
                        })
                        Button(action: {
                            Task{
                                await deleteAccount()
                            }
                        }, label: {
                            VStack {
                                Image(systemName:"minus.circle")
                                    .foregroundStyle(.black)
                                Text("Delete Acc.")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.black)
                            }
                            
                        })
                    }
                })
        }
    }
}

struct AddBulkMealView: View{
    
    @ObservedObject private var bulkViewModel = MealsViewModel()
    
    @State var name:String = ""
    @State var ingredients:[String] = [""]
    @State var calories:Int = 0
    @State var protein:Int = 0
    @State var carbs:Int = 0
    @State var fats:Int = 0
    @State var imageURL:String = ""
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    var body: some View{
        
        ScrollView {
            VStack(spacing: 15){
                InputView(text: $name, title: "Meal Name", placeHolder: "enter meal name")
                //List of ingredient text fields
                ForEach(ingredients.indices, id: \.self){
                    index in
                    InputView(text: $ingredients[index], title: "Add each ingredient ", placeHolder: "Enter Ingredient")
                    Button {
                        ingredients.append("")
                    } label: {
                        Text("Add new ingredient")
                            .foregroundStyle(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(Color(mainColor))
                                    .frame(width: 170, height: 20)
                            )
                            
                    }

                }//end of the for loop
                InputView(text: $calories, title: "Calories", placeHolder: "calories")
                InputView(text: $protein, title: "Protein", placeHolder: "protein(g)")
                InputView(text: $carbs, title: "Carbs", placeHolder: "carbs(g)")
                InputView(text: $fats, title: "Fats", placeHolder: "fats(g)")
                InputView(text: $imageURL, title: "Enter Image URL", placeHolder: "URL link")
                
                Button{
                    bulkViewModel.addBulkMeal(name: name, ingredients: ingredients, calories: calories, protein: protein, fats: fats, imageURL: imageURL)
                }
                label:{
                    Text("add bulk meal")
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(mainColor))
                                .frame(width: 130, height: 40)
                        )
                }

            }
        }
    }
}

struct AddCutMealView: View{
    
    @ObservedObject private var bulkViewModel = MealsViewModel()
    
    @State var name:String = ""
    @State var ingredients:[String] = [""]
    @State var calories:Int = 0
    @State var protein:Int = 0
    @State var carbs:Int = 0
    @State var fats:Int = 0
    @State var imageURL:String = ""
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    var body: some View{
        
        ScrollView {
            VStack(spacing: 10){
                InputView(text: $name, title: "Meal Name", placeHolder: "enter meal name")
                //List of ingredient text fields
                ForEach(ingredients.indices, id: \.self){
                    index in
                    InputView(text: $ingredients[index], title: "Add each ingredient ", placeHolder: "Enter Ingredient")
                    Button {
                        ingredients.append("")
                    } label: {
                        Text("Add new ingredient")
                            .foregroundStyle(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(Color(mainColor))
                                    .frame(width: 170, height: 20)
                            )
                            
                    }

                }//end of the for loop
                InputView(text: $calories, title: "Calories", placeHolder: "calories")
                InputView(text: $protein, title: "Protein", placeHolder: "protein(g)")
                InputView(text: $carbs, title: "Carbs", placeHolder: "carbs(g)")
                InputView(text: $fats, title: "Fats", placeHolder: "fats(g)")
                InputView(text: $imageURL, title: "Enter Image URL", placeHolder: "URL link")
                
                Button{
                    bulkViewModel.addCutMeal(name: name, ingredients: ingredients, calories: calories, protein: protein, fats: fats, imageURL: imageURL)
                }
                label:{
                    Text("add cut meal")
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(mainColor))
                                .frame(width: 130, height: 40)
                        )
                }

            }
        }
    }
}


struct addWorkoutView: View{
    
    @ObservedObject var workoutViewModel = WorkoutsViewModel()
    @State var name:String = ""
    @State var muscleGroup:String = ""
    @State var reps:String = ""
    @State var tips:[String] = [""]
    @State var imageURL:String = ""
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    var body: some View{
        ScrollView{
            VStack(spacing: 10){
                InputView(text: $name, title: "Workout Name", placeHolder: "enter workout name")
                InputView(text: $muscleGroup, title: "Muscle Group", placeHolder: "Upper/Lower/Full Body")
                InputView(text: $reps, title: "Reps", placeHolder: "enter reps")
                
                //List of ingredient text fields
                ForEach(tips.indices, id: \.self){
                    index in
                    InputView(text: $tips[index], title: "Add each Tip ", placeHolder: "Enter Tips")
                    Button {
                        tips.append("")
                    } label: {
                        Text("Add new tip")
                            .foregroundStyle(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(Color(mainColor))
                                    .frame(width: 170, height: 20)
                            )
                            
                    }

                }//end of the for loop
                
                InputView(text: $imageURL, title: "Image URL", placeHolder: "enter URL")
            }
        }
    }
}

#Preview {
    AdminAccSetting()
}
