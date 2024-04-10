//
//  BulkMeals.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/2/24.
//

import Foundation

struct Meals: Identifiable{
    
    
    let id:String = NSUUID().uuidString
    let name: String
    let ingredient: [String]
    let calories: Int
    let protein: Int
    let carbs: Int
    let fats: Int
    let imageURL: String
    
}




