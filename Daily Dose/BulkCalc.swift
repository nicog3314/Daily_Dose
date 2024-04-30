//
//  BulkCalc.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/1/24.
//

import Foundation

class BulkCalc{
    
    func calcPlan(weight: Int){
        
        // Example formula for calculating daily calorie intake
                let calorieIntake = weight * 20 
                
                // Example formula for calculating macronutrient distribution
                let protein = Int(Double(weight) * 1.2) // 1.2 grams per pound of body weight
                let carbs = Int(Double(calorieIntake) * 0.5 / 4) // 50% of calories from carbs (4 calories per gram)
                let fats = Int(Double(calorieIntake) * 0.3 / 9) // 30% of calories from fats (9 calories per gram)
                
                // workout plan based on weight
                var workoutPlan = ""
                if weight < 150 {
                    workoutPlan = "3 days a week of weightlifting"
                } else if weight < 180 {
                    workoutPlan = "4 days a week of weightlifting"
                } else {
                    workoutPlan = "5 days a week of weightlifting"
                }
               
    }
}
