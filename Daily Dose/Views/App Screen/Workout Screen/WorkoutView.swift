//
//  WorkoutView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 4/15/24.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workoutViewModel = WorkoutsViewModel()
    
    var body: some View {
        NavigationView {
            //list of all bulk meals
            List {
                Section("") {
                    ForEach(workoutViewModel.workouts) { workout in
                        NavigationLink {
                            WorkoutInfo(workout: workout)
                        } label: {
                            HStack {
                                // Image of the meal
                                AsyncImage(url: URL(string: workout.imageURL)) { image in
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
                                Text(workout.name)
                                    .font(.title3).bold()
                            }
                        }
                    }
                }
            }
            .onAppear {
                workoutViewModel.fetchWorkouts()
            }
            .navigationTitle("Get the sweat going!")
        }
    }
}
struct WorkoutInfo:View{
    let workout:Workouts
    var body: some View{
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: workout.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .cornerRadius(15)
            } placeholder: {
                ProgressView()
            }
            .shadow(radius: 10)
                
            Text("Name: \(workout.name)")
                .fontWeight(.medium)
            Text("Muscle Group: \(workout.muscleGroup)")
                .fontWeight(.medium)
            Text("Reps: \(workout.reps)")
                .fontWeight(.medium)
            Text("Tips: \(workout.tips.joined(separator: "\n"))")
                .fontWeight(.medium)
        }
            .padding()
    }
}


#Preview {
    WorkoutView()
}
