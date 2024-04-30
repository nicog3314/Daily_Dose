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
    
    func addBulkMeal(name: String, ingredients: [String], calories: Int, protein: Int, fats: Int, imageURL:String ){
        //creates a generated ID for the new documents added/created
        db.collection("bulkMeals").addDocument(data: [
            "name": name,
            "ingredients":ingredients,
            "calories": calories,
            "protein": protein,
            "fats": fats,
            "imageURL": imageURL
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
                let protein = data["protein"] as? Int ?? 0
                let carbs = data["carbs"] as? Int ?? 0
                let fats = data["fats"] as? Int ?? 0
                let imageURL = data["imageURL"] as? String ?? ""

                return Meals(name: name, ingredient: ingredient, calories: calories, protein: protein, carbs: carbs, fats: fats, imageURL: imageURL)
            }
        }
    }


    
   

    func addCutMeal(name: String, ingredients: [String], calories: Int, protein: Int, fats: Int, imageURL:String ){
        //creates generated id for the new documents added/created
        db.collection("cutMeals").addDocument(data: [
            "name": name,
            "ingredients": ingredients,
            "calories": calories,
            "protein": protein,
            "fats": fats,
            "imageURL": imageURL
        ])
    }
    
    func fetchCutMeals() {
        db.collection("cutMeals").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            
            self.meals = documents.map { (queryDocumentSnapshot) -> Meals in
                let data = queryDocumentSnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let ingredient = data["ingredients"] as? [String] ?? [""]
                let calories = data["calories"] as? Int ?? 0
                let protein = data["protein"] as? Int ?? 0
                let carbs = data["carbs"] as? Int ?? 0
                let fats = data["fats"] as? Int ?? 0
                let imageURL = data["imageURL"] as? String ?? ""

                return Meals(name: name, ingredient: ingredient, calories: calories, protein: protein, carbs: carbs, fats: fats, imageURL: imageURL)
            }
        }
    }
}

