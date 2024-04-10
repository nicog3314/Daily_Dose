//
//  Daily_DoseApp.swift
//  Daily Dose
//
//  Created by Nicole Gonzalez on 2/13/24.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore


@main
struct Daily_DoseApp: App {
    
//        
    // connecting the Firebase to the Daily Dose App
//        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @EnvironmentObject var viewModel:AuthView
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }


//    class AppDelegate: NSObject, UIApplicationDelegate {
//      func application(_ application: UIApplication,
//                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//      }
//    }
    
}
