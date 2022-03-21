//
//  MiniInstagramApp.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FacebookLogin

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
                .onOpenURL { url in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Initializing Firebase
        FirebaseApp.configure()
        
        return true
    }
    
//    func application(_ application: UIApplication, open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any])
//      -> Bool {
//          
//      return GIDSignIn.sharedInstance.handle(url)
//    }
    
}
