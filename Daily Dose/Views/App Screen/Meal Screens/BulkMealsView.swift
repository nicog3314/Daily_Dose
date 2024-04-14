//
//  BulkMealsView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/9/24.
//

import SwiftUI

struct BulkMealsView: View {
    @ObservedObject private var viewModel = MealsViewModel()
    var body: some View {
        
        NavigationView {
            
                    List {
                        ForEach(viewModel.meals) { meal in
                            DisclosureGroup {
                                MealInfo(meal: meal)
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
                                        .font(.headline)
                                }
                            }
                        }
                        
                    }
                    .onAppear {
                        viewModel.fetchBulkMeals()
                    }
        }
    }
}


struct MealInfo: View {
    let meal: Meals
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                Text("Ingredients: \(meal.ingredient.joined(separator: ", "))")
                   Text("Calories: \(meal.calories)")
                   Text("Fats: \(meal.fats)g")
                   Text("Proteins: \(meal.protein)g")
                   Text("Carbs: \(meal.carbs)g")
               }
               .padding(.vertical, 4)
    }
}
#Preview {
    BulkMealsView()
}
