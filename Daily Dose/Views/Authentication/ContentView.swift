//
//  ContentView.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 3/4/24.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthView
    
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                MainScreen()
           }
            else{
                LogInView()
            }
        }
    }
}

#Preview {
    ContentView()
}
