//
//  FacebookLoginView.swift
//  MiniInstagram
//
//  Created by İsmail on 20.03.2022.
//

import SwiftUI
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin
import FacebookCore
import Firebase

struct FaceBookLoginView: UIViewRepresentable {
    
    func makeCoordinator() -> FaceBookLoginView.Coordinator {
        return FaceBookLoginView.Coordinator()
    }
    
    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
              print(error.localizedDescription)
              return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            AuthViewModel.shared.facebookLogin(credentials: credential)
            
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//              if let error = error {
//                print(error.localizedDescription)
//                return
//              }
//              print("Facebook Sign In")
//            }
        }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<FaceBookLoginView>) -> FBLoginButton {
        let view = FBLoginButton()
        
//        Settings.shared.appID = "1165774317294989"
//        Settings.shared.displayName = "MiniSocialMediaApp"
//        Settings.shared.clientToken = "5cc16364b43d6a208cdc35ead9fb1010"
//        
//        print("DEBUG: Facebook appID from Facebook Login View: \(Settings.shared.appID)")
        
        view.permissions = ["email", "public_profile"]
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookLoginView>) { }
}
