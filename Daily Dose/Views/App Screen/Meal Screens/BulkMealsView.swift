//
//  BulkMealsView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/9/24.
//

import SwiftUI

struct BulkMealsView: View {
    @ObservedObject private var bulkViewModel = MealsViewModel()
    @EnvironmentObject var viewModel:AuthView
    var body: some View {
        
        NavigationView {
            //list of all bulk meals
           
            List {
                Section("") {
                    ForEach(bulkViewModel.meals) { meal in
                        NavigationLink {
                            BulkMealInfo(meal: meal)
                        } label: {
                            HStack {
                                // Image of the meal
                                AsyncImage(url: URL(string: meal.imageURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 75, height: 75)
                                        .cornerRadius(15)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 75, height: 75)
                                .shadow(radius: 10)
                                
                                // Name of the meal
                                Text(meal.name)
                                    .font(.title3).bold()
                            }
                        }
                    }
                }
            }
            .onAppear {
                bulkViewModel.fetchBulkMeals()
            }
            .navigationTitle("Time to Bulk Out!")
            
        }
        
        
        
    }
}


struct BulkMealInfo: View {
    let meal: Meals
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: meal.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .cornerRadius(15)
            } placeholder: {
                ProgressView()
            }
            .shadow(radius: 10)
                
            Text("Ingredients: \(meal.ingredient.joined(separator: ", "))")
                .fontWeight(.medium)
            Text("Calories: \(meal.calories)")
                .fontWeight(.medium)
            Text("Fats: \(meal.fats)g")
                .fontWeight(.medium)
            Text("Protein: \(meal.protein)g")
                .fontWeight(.medium)
            Text("Carbs: \(meal.carbs)g")
                .fontWeight(.medium)
        }
        .padding()
    }
}
#Preview {
    BulkMealsView()
}
