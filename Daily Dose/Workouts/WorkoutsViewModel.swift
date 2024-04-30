//
//  WorkoutsViewModel.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/15/24.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class WorkoutsViewModel: ObservableObject{
    
    private let  db = Firestore.firestore()
    @Published var workouts = [Workouts] ()
    
    func fetchWorkouts() {
        db.collection("workouts").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            self.workouts = documents.map{ (querySnapshot) -> Workouts in
                let data = querySnapshot.data()
                
                let name = data["name"] as? String ?? ""
                let muscleGroup = data["muscleGroup"] as? String ?? ""
                let reps =  data["reps"] as? String ?? ""
                let tips = data["tips"] as? [String] ?? [""]
                let imageURL = data["imageURL"] as? String ?? ""
                
                return Workouts(name: name, muscleGroup: muscleGroup, reps: reps, tips: tips, imageURL: imageURL)
            }
        }
    }
    
    func addWorkouts(name:String, muscleGroup: String, reps: String, tips: [String], imageURL:String)  {
        //add workouts to database
        db.collection("workouts").addDocument(data: [
            "name": name,
            "muscleGroup": muscleGroup,
            "reps": reps,
            "tips": tips,
            "imageURL": imageURL
        ])
    }
}
