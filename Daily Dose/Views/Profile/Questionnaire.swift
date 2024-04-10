//
//  Questionnaire.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/25/24.
//

import SwiftUI

struct Questionnaire: View {
    
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    @EnvironmentObject var viewModel: AuthView
    
    @State var weight:Int = 0
    var isSeleted: Bool = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(spacing: 50) {
            Image(systemName: "dumbbell")
                .resizable()
                .frame(width: 190, height: 100)
            Text("take control.")
            
            //Questions for the space
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
                            .foregroundColor(mainColor)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(Color(.black))
                                    .frame(width: 130, height: 40)
                            )
                    }
                    
                    
                Spacer()
                HStack{
                    //bulk option
                    Button{
                        Task{
                             try await viewModel.bulk()
                        }
                    }
                label:{
                    Text("Bulk")
                        .padding(.all)
                        .background(Color.gray.ignoresSafeArea().opacity(0.3))
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
                        .background(Color.gray.ignoresSafeArea().opacity(0.3))
                        .cornerRadius(100)
                        .foregroundColor(.black)
                    }
                }.position(x: 190, y: 100 )
            }.position(x: 200, y: 300 )
            Button{
                Task{
                    dismiss()
                }
               
            }
                label: {
                    Text("back")
                        .foregroundColor(mainColor)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .foregroundColor(Color(.black))
                                .frame(width: 130, height: 40)
                        )
                }
            
        }.navigationBarBackButtonHidden().background(mainColor)
    }
}

#Preview {
    Questionnaire()
}
