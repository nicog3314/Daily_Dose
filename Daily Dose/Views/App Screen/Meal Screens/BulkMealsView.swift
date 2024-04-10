//
//  BulkMealsView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/9/24.
//

import SwiftUI


//let testData = [
//    Meals(id: NSUUID().uuidString, name: "Test", ingredient: ["1", "2", "3", "yum"], calories: 100, protein: 30, carbs: 20, fats: 10, imageURL: "test.org"),
//    Meals(id: NSUUID().uuidString, name: "Test", ingredient: ["1", "2", "3", "ew"], calories: 100, protein: 30, carbs: 20, fats: 10, imageURL: "test.com"),
//    Meals(id: NSUUID().uuidString, name: "Test", ingredient: ["1", "2", "3", "4", "5"], calories: 100, protein: 30, carbs: 20, fats: 10, imageURL: "test.org")
//]

struct BulkMealsView: View {
    
    
//    init(){
//        UINavigationBar.appearance().backgroundColor = .opaqueSeparator
//    }
    
    
    @ObservedObject private var viewModel = MealsViewModel()
//    var meals = testData
    var body: some View {
        
        NavigationView{
            List(viewModel.meals){
                meal in
                VStack(alignment: .leading){
                    Text(meal.name)
                        .font(.headline)
                    Text(meal.ingredient.joined())
                        .font(.subheadline)
                    Text(meal.calories.formatted())
                        .font(.subheadline)
                    Text(meal.protein.formatted())
                        .font(.subheadline)
                    Text(meal.carbs.formatted())
                        .font(.subheadline)
                    Text(meal.fats.formatted())
                        .font(.subheadline)
                }
            }
        }
        .onAppear(){
            self.viewModel.fetchBulkMeals()
            }
        }
}

#Preview {
    BulkMealsView()
}
