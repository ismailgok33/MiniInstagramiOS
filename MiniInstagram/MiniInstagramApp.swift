//
//  MiniInstagramApp.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Firebase

@main
struct MiniInstagramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
//            LoginView().environmentObject(AuthViewModel())
        }
    }
}
