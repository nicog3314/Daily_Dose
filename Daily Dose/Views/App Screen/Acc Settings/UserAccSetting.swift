//
//  UserAccSetting.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 3/19/24.
//

import SwiftUI



struct UserAccSetting: View {
    @EnvironmentObject var viewModel: AuthView
    
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    @State var weight: Int = 0
    @Environment(\.dismiss) var dismiss
    
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
       
        
        NavigationView{
            
            ZStack{
                //if let user = viewModel.currentUser{
                //VStack with dumbbell and text
                VStack{
                    Image(systemName: "dumbbell")
                        .resizable()
                        .frame(width: 190, height: 100)
                        .foregroundColor(mainColor)
                    Text("take control.")
                }.position(x: 200, y: 100)
                //VStack with the weight input
                VStack(spacing: 2){
                    Text("Made progress? Update your weight!")
                        .foregroundColor(.black)
                        .font(.system(size: 20.0))
                    
                    TextField("Weight (lbs)", value: $weight, format: .number)
                        .padding()
                        .background(Color.gray.opacity(0.30))
                        .cornerRadius(20)
                        .frame(width: 350, height: 100)
                    
                    Button{
                        Task{
                            try await viewModel.weight(userWeight: weight )
                        }
                        
                    }
                    label: {
                        Text("change weight")
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color(.black))
                                    .frame(width: 130, height: 40)
                            )
                    }
                }.position(x: 200, y: 300)
                
                //V and H Stacks with bulk and cut setting
                VStack{
                    Text("Set your goal!")
                    HStack(spacing: 20){
                        //bulk option
                        Button{
                            Task{
                                try await viewModel.bulk()
                            }
                        }
                    label:{
                        Text("Bulk")
                            .padding()
                            .background(Color(mainColor).ignoresSafeArea().opacity(0.6))
                            .cornerRadius(100)
                            .foregroundColor(.black)
                    }
                        //cut option
                        Button{
                            Task{
                                try await viewModel.cut()
                            }
                        }
                    label:{
                        Text("Cut")
                            .padding()
                            .background(Color(mainColor).ignoresSafeArea().opacity(0.6))
                            .cornerRadius(100)
                            .foregroundColor(.black)
                        }
                    }
                }.position(x: 200, y: 500)
                
            }
            .navigationTitle("Account Settings")
            .toolbar(content: {
                ToolbarItemGroup {
                    Button(action: {
                        Task{
                            await signOut()
                        }
                    }, label: {
                        VStack {
                            Image(systemName: "arrow.right.to.line.compact")
                                .foregroundColor(.black)
                            Text("Log Out")
                                .font(.system(size: 15))
                                .foregroundStyle(.black)
                        }
                        
                    })
                    Button(action: {
                        Task{
                            await deleteAccount()
                        }
                    }, label: {
                        VStack {
                            Image(systemName:"minus.circle")
                                .foregroundStyle(.black)
                            Text("Delete Acc.")
                                .font(.system(size: 15))
                                .foregroundStyle(.black)
                        }
                        
                    })
                }
            }).toolbarBackground(.tint)
        }
    }
    
}

#Preview {
    UserAccSetting()
}
