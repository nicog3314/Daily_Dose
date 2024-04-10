//
//  UserAccSetting.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 3/19/24.
//

import SwiftUI



struct UserAccSetting: View {
    @EnvironmentObject var viewModel: AuthView
    
    func signOut() async{
        await viewModel.signOut()
    }
    
    func deleteAccount() async{
        do{
            try await viewModel.deleteAccount()
        }catch{
            print("DEBUG:cannot delete account")
        }
    }
    var body: some View {
            
        let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
      
        NavigationView{
            ZStack{
                Color(mainColor).ignoresSafeArea()
                if let user = viewModel.currentUser{
                    VStack{
                        Text("Account Settings")
                        Text("Welcome \(user.first)!")
                        
                        Button(action: {
                            Task{
                                await signOut()
                            }
                        }, label: {
                            Text("Log Out")
                        })
                        
                        Button(action: {
                            Task{
                                await deleteAccount()
                            }
                        }, label: {
                            Text("Delete Account")
                        })
                    }
                }
            }
        }
        
    }
}

#Preview {
    UserAccSetting()
}
