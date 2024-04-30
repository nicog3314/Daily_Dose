//
//  InputView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/25/24.
//

import SwiftUI

struct InputView<T: LosslessStringConvertible>: View {
    @Binding var text: T
    let title: String
    let placeHolder: String
    var isSecureField: Bool = false
    
    let mainColor: Color = Color(red: 0.876, green: 0.911, blue: 0.762)
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(Color(mainColor))
                .fontWeight(.semibold)
                .font(.title2)
            
            if isSecureField {
                SecureField(placeHolder, text: Binding<String>(
                    get: { String(text) },
                    set: {
                        if let value = T($0) {
                            text = value
                        }
                    })
                )
                .font(.system(size: 14))
                .padding()
                .background(Color.gray.opacity(0.3))
                .frame(width: 350, height: 40)
                .cornerRadius(20)
                .foregroundColor(.white)
            } else {
                TextField(placeHolder, text: Binding<String>(
                    get: { String(text) },
                    set: {
                        if let value = T($0) {
                            text = value
                        }
                    })
                )
                .font(.system(size: 14))
                .padding()
                .background(Color.gray.opacity(0.3))
                .frame(width: 350, height: 40)
                .cornerRadius(20)
                .foregroundColor(.white)
            }
        }
    }
}


#Preview {
    InputView(text: .constant(""), title: "Email Address:", placeHolder: "name@email.com")
}
