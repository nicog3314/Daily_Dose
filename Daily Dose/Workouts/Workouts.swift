//
//  Workouts.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/15/24.
//

import Foundation

struct Workouts: Identifiable{
    let id: String = NSUUID().uuidString
    let name: String
    let muscleGroup: String
    let reps: String
    let tips: [String]
    let imageURL:String
}
