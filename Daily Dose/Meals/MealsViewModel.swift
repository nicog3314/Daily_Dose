//
//  MealsViewModel.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/9/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


@MainActor
//Maniplulating the meals from database
class MealsViewModel: ObservableObject{
    
    private let  db = Firestore.firestore()
    @Published var meals = [Meals] ()
    
    func addBulkMeal(meal: Meals){
        //creates a generated ID for the new documents added/created
        db.collection("bulkMeals").addDocument(data: [
            "name": meal.name,
            "ingredients": meal.ingredient,
            "calories": meal.calories,
            "proteins": meal.protein,
            "fats": meal.fats,
            "imageURL": meal.imageURL
        ])
        
    }

    func fetchBulkMeals() {
        db.collection("bulkMeals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            
            self.meals = documents.map { (queryDocumentSnapshot) -> Meals in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let ingredient = data["ingredients"] as? [String] ?? [""]
                let calories = data["calories"] as? Int ?? 0
                let protein = data["proteins"] as? Int ?? 0
                let carbs = data["carbs"] as? Int ?? 0
                let fats = data["fats"] as? Int ?? 0
                let imageURL = data["imageURL"] as? String ?? ""

                return Meals(name: name, ingredient: ingredient, calories: calories, protein: protein, carbs: carbs, fats: fats, imageURL: imageURL)
            }
        }
    }


    
   

    func addCutMeal(meal: Meals){
        //creates generated id for the new documents added/created
        db.collection("cutMeals").addDocument(data: [
            "name": meal.name,
            "ingredients": meal.ingredient,
            "calories": meal.calories,
            "proteins": meal.protein,
            "fats": meal.fats,
            "imageURL": meal.imageURL
        ])
    }
    
}

