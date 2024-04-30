//
//  MainScreen.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/25/24.
//

import SwiftUI
import Firebase

struct MainScreen: View {
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    @EnvironmentObject var viewModel: AuthView
    @State private var userHealthGoal: String = ""
    @State private var isAdmin:String = ""
    
    var body: some View {
        NavigationStack() {
            ZStack {
                // Adding BulkMealsView if user's health goal is "bulk"
                TabView  {
                    Group {
                        if userHealthGoal == "bulk" {
                            BulkMealsView()
                                .cornerRadius(15)
                                .scrollContentBackground(.hidden)
                                .tabItem {
                                    Label("Meals", systemImage: "fork.knife")
                                }
                        }
                        else if userHealthGoal == "cut"{
                            CutMealsView()
                                .cornerRadius(15)
                                .scrollContentBackground(.hidden)
                                .tabItem {
                                    Label("Meals", systemImage: "fork.knife")
                                }
                        }
                        else{
                            VStack {
                                Text("Set your goal!")
                                Text("Go to Settings!")
                                
                            }.tabItem {
                                Label("Meals", systemImage: "fork.knife")
                            }
                        }
                    }//fetching the user health goal when screen appears
                    .onAppear {
                        Task {
                            do {
                                let fetch = try await fetchGoal()
                                self.userHealthGoal = fetch
                            } catch {
                                print("DEBUG: CANNOT GET HEALTHGOAL/HEALTHGOAL NOT SET")
                            }
                        }
                    }
                            WorkoutView()
                                .tabItem {
                                    Label("Workouts", systemImage: "dumbbell")
                                }
                            
                    Group{
                        if isAdmin == "true" {
                            AdminAccSetting()
                            .tabItem {
                                if let user = viewModel.currentUser{
                                    Label("\(user.first)", systemImage: "person.fill")
                                }
                            }
                        }
                        else {
                            UserAccSetting()
                                .tabItem {
                                    if let user = viewModel.currentUser{
                                        Label("\(user.first)", systemImage: "person.fill")
                                    }
                                }
                        }
                    }
                    .onAppear{
                        Task{
                            do{
                                let fetch = try await fetchAdmin()
                                self.isAdmin = fetch
                            }catch{
                                print("DEBUG: ADMIN STATUS NOT FOUND")
                            }
                        }
                        
                    }
                }
            }
        }
    }
}


func fetchGoal() async throws  -> String{
    guard let uid = Auth.auth().currentUser?.uid else { throw NSError(domain: "com.yourcompany.dailyDose", code: 0)}
    
    let userDB = Firestore.firestore().collection("user").document(uid)
    let snapshot = try await userDB.getDocument()
    
    if let healthGoal = snapshot.get("healthGoal") as? String{
        return healthGoal //return healthGoal if found
    }else{
        throw NSError(domain: "com.yourcompany.dailyDose", code: 0, userInfo:[NSLocalizedDescriptionKey:"Health goal cannot be found"])
    }
}

func fetchAdmin () async throws -> String{
    guard let uid = Auth.auth().currentUser?.uid else { throw NSError(domain: "com.yourcompany.dailyDose", code: 0)}
    
    let userDB = Firestore.firestore().collection("user").document(uid)
    let snapshot = try await userDB.getDocument()
    
    if let isAdmin = snapshot.get("isAdmin") as? String{
        return isAdmin //return admin status if found
    }else{
        throw NSError(domain: "com.yourcompany.dailyDose", code: 0, userInfo:[NSLocalizedDescriptionKey:"Health goal cannot be found"])
    }
    
}


#Preview {
    MainScreen()
}
