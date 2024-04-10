//
//  ContentView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/13/24.
//

import SwiftUI
import Swift

import Firebase



struct LogInView: View {
    
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    @State private var email:String = ""
    @State private var password:String = ""
    
    @EnvironmentObject var viewModel:AuthView
    
    var body:some View{
        //full screen color
        NavigationView {
            Color.black.ignoresSafeArea()
            //Daily Dose
                .overlay(
                        Text("Daily Dose")
                        .font(.system(size: 45, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .position(x: 191, y:130)
                        .background(
                            Image(.greenBlob)
                                .resizable()
                                .frame(width: 330, height:230)
                            .position(x:191, y: 140)
                        )
                      
                )
                .overlay(Image(systemName: "dumbbell")
                    .resizable()
                    .frame(width: 50, height: 30)
                    .position(x:191, y:180)
                )
            
            //Rectangles
                .overlay(
                    VStack(spacing: 20){
                        InputView(text: $email,
                                  title: "Email Address:",
                                  placeHolder: "name@exmaple.com")
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                        InputView(text: $password,
                                  title: "Password", 
                                  placeHolder: "enter password",
                                  isSecureField: true)
                    }
                        
                )
            //Sign in button
                .overlay(
                    Button{
                        Task{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    }
                   label: {
                    Text("sign in")
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(mainColor))
                                .frame(width: 130, height: 40)
                        )
                        }.position(x:205, y: 625)
                )
            //Create Account Navigation Link
                . overlay(
                    NavigationLink(
                        destination: CreateAccount()
                            .navigationBarBackButtonHidden(true)
                            .toolbar(.hidden),
                        label: {
                            Text("create account")
                                .foregroundColor(Color.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .foregroundColor(Color(mainColor))
                                        .frame(width: 130, height: 40)
                                )
                        }
                    )
                    .position(x:205, y: 700)
            )
        }
        
    }
}


    
#Preview{
    LogInView()
}

