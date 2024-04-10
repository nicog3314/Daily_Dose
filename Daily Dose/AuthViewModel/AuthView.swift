//
//  AuthView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor
class AuthView: ObservableObject{
    
    //firebase auth user object
    @Published var userSession: FirebaseAuth.User?
    //user created
    @Published var currentUser: User?
    
    init(){
        //check
        self.userSession = Auth.auth().currentUser
        
        Task{
            //just trying to fetch the user data right away
            await fetchUser()
        }
    }
    
func signIn(withEmail email: String, password:String) async throws{
    do{
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
        await fetchUser()
    }   catch{
        print("DEBUG: failed to log in with error \(error.localizedDescription)")
    }
}

func createUser(withEmail email: String, password: String, first:String, last:String) async throws{
    do{
        //creating the user based on the firebase code
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        
        //if we get a result back from the user creation, set the user into the User Session
        //property
        self.userSession = result.user
        
        //create user object for code
        let user = User(id: result.user.uid, first: first, last: last, email: email)
        
        
        //encode the user
        let encodedUser = try Firestore.Encoder().encode(user)
        
        //upload the data to firestore from each user created
        try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
        await fetchUser()
    }
    catch{
        print("DEBUG: failed to create user \(error.localizedDescription)")
    }
}

func signOut(){
    do{
        
        try Auth.auth().signOut()//signs out user on backend
        
        self.userSession = nil //wipes out users sesion and takes to login screen
        
        self.currentUser = nil //wipes out current user object
    }catch{
        print("DEBUG: failed to sign out with error \(error.localizedDescription)")
    }
    
}

func deleteAccount() async throws{
    //getting current uer
    guard let user = Auth.auth().currentUser else { return }
    //deleting id document of the current user
    try await Firestore.firestore().collection("user").document(user.uid).delete()
    //deleting user from authentication
    try await user.delete()
    //setting both the curr user & user session to nil -> goes back to sign in screen
    self.userSession = nil
    self.currentUser = nil
}

func fetchUser() async {
    
    //get current users id
    guard let uid = Auth.auth().currentUser?.uid else {return}
    //getting the uid from current user from the user collection in firebase
    guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else {return}
    
    self.currentUser = try? snapshot.data(as: User.self)
    
    print("DEBUG: Current user is \(self.currentUser)")
    
}
    
    
func bulk() async throws {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    let db = Firestore.firestore().collection("user").document(uid)
    
    
    if try await (db.getDocument().get("healthGoal") == nil){
        do{
            //add bulk to the users info if the healthGoal field is nill
            try await db.setData(["healthGoal" : "bulk"], merge: true)
        }
        catch{
            print("DEBUG: cannot add to user info \(error.localizedDescription)")
        }
    }
    else{
        
        //if it does exist, then let the users healthgoal = bulk
        try await db.updateData(["healthGoal" : "bulk"])
    }
   
}


func cut() async throws {
    guard let uid = Auth.auth().currentUser?.uid else {return}
    let db = Firestore.firestore().collection("user").document(uid)
    
    
    //if the healthGoal field = nil then add it to the user field
    if try await (db.getDocument().get("healthGoal") == nil){
        do{
            //add bulk to the users info
            try await db.setData(["healthGoal" : "cut"], merge: true)
        }
        catch{
            print("DEBUG: cannot add to user info \(error.localizedDescription)")
        }
    }
    //if the healthGoal field already exists, change the user health goal to cut
    else{
        try await db.updateData(["healthGoal" : "cut"])
    }
    
    
}

func weight(userWeight: Int) async throws {
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let db = Firestore.firestore().collection("user").document(uid)
    
    if try await(db.getDocument().get("weight") == nil){
        do{
            try await db.setData([
                "weight" : userWeight],
                                 merge: true)
        }catch{
            print("DEBUG: weight could not be added")
        }
    }
    else{
        try await db.updateData(["weight" : userWeight])
    }
}

}
