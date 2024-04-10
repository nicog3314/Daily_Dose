//
//  CreateAccount.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/25/24.
//

import SwiftUI

struct CreateAccount: View {
    
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    @State var first:String = ""
    @State var last:String = ""
    @State var pword:String = ""
    @State var confirmPwrd:String = ""
    @State var email:String = ""
    
    @EnvironmentObject var viewModel: AuthView
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        Color.black.ignoresSafeArea()
                
                .overlay(
                    VStack {
                        Text("Daily Dose")
                        .font(.system(size: 25, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .position(x: 191, y:120)
                        .background(
                            Image(.greenBlob)
                                .resizable()
                                .frame(width: 150, height:120)
                            .position(x:191, y: 120)
                        )
                        VStack(spacing: 10, content: {
                                //First
                               InputView(text: $first, title: "First Name", placeHolder: "")
                                
                                //Last
                                InputView(text: $last, title: "Last Name", placeHolder: "")
                                //Email
                                InputView(text: $email, title: "Email", placeHolder: "")
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                //Password
                                InputView(text: $pword, title: "Password", placeHolder: "", isSecureField: true)
                                //Re-Enter password
                                InputView(text: $confirmPwrd, title: "Confirm Pasword", placeHolder: "", isSecureField: true)
                            Button{
                                Task {
                                    try await viewModel.createUser(
                                        withEmail:email,
                                        password: pword,
                                        first: first,
                                        last: last)
                                }
                            }
                            
                                    label: {
                                    Text("create account")
                                        .foregroundColor(Color.black)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .foregroundColor(Color(mainColor))
                                                .frame(width: 130, height: 40)
                                        )
                                    }
                                    .padding(.top, 13)
                                Button {
                                    dismiss()
                                } label: {
                                    Text("back")
                                        .foregroundColor(.black)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(Color(mainColor))
                                            .frame(width: 130, height:40)
                                        )
                                }.padding(.top, 13)
                                
                                }
                        )
                    }
            )
        }
    }


#Preview {
    CreateAccount()
}
