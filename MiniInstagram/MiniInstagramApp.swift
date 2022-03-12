//
//  MiniInstagramApp.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct MiniInstagramApp: App {
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    // Connecting app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
//            LoginView().environmentObject(AuthViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Initializing Firebase
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          print("DEBUG: girdi")
          
      return GIDSignIn.sharedInstance.handle(url)
    }
    
}
