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
    
    @State private var healthGoal: String = ""
    var body: some View {
        NavigationStack() {
            ZStack {
                Color(.lightGray).ignoresSafeArea()
                
                NavigationLink(
                    destination: UserAccSetting(),
                    label: {
                        Text("Account Settings")
                            .foregroundColor(mainColor)
                            .bold()
                            .background(
                                RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.black)
                                    .frame(width: 176, height: 20)
                            )
                    }
                )
                .position(x: 300, y: 50)
                
                NavigationLink(
                    destination: Questionnaire(),
                    label: {
                        Text("Questionnaire")
                            .foregroundColor(mainColor)
                            .bold()
                            .background(
                                RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.black)
                                    .frame(width: 176, height: 20)
                            )
                    }
                )
                .position(x: 300, y: 70)
                .navigationBarBackButtonHidden()
                
                // Adding BulkMealsView if user's health goal is "bulk"
                if userHealthGoal == "bulk" {
                    BulkMealsView()
                        .frame(width:400, height:600)
                        .padding()
                        .cornerRadius(15)
                        .position(x: 200, y: 550)
                }
                else if userHealthGoal == "cut"{
                    CutMealsView()
                }
                else{
                    VStack {
                        Text("Go to Questionnaire!")
                        Text("Set your goal!")
                    }
                   
                }
            }
            .onAppear {
                Task {
                    do {
                        let fetch = try await fetchGoal()
                        self.userHealthGoal = fetch
                    } catch {
                        print("DEBUG: CANNOT GET HEALTHGOAL")
                    }
                }
            }
        }
    }
}


func fetchGoal() async throws  -> String{
    guard let uid = Auth.auth().currentUser?.uid else { throw NSError(domain: "com.example.app", code: 0)}
    
    let userDB = Firestore.firestore().collection("user").document(uid)
    let snapshot = try await userDB.getDocument()
    
    if let healthGoal = snapshot.get("healthGoal") as? String{
        return healthGoal //return healthGoal if found
    }else{
        throw NSError(domain: "com.example.app", code: 0, userInfo:[NSLocalizedDescriptionKey:"Health goal cannot be found"])
    }
}



#Preview {
    MainScreen()
}
