//
//  AuthViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User? // used for using User Info in the profile and other screens
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: LoginView.getRootViewController()) {[self] user, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            // Firebase Auth
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("DEBUG: Login failed: \(error.localizedDescription)")
                    return
                }
                
                guard let user = result?.user else { return }
                
                let data = ["email": user.email, "username": user.displayName, "fullname": user.displayName, "profileImageURL": user.photoURL?.absoluteString, "uid": user.uid]
                
//                self.userSession = user
//                self.fetchUser()
                
                print("DEBUG: data is \(data)")
                
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("DEBUG: Successfully uploaded user data..")
                    self.userSession = user
                    self.fetchUser()
                }
            }
            
        }
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        
//        guard let image = image else { return }
//
//        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
//            Auth.auth().createUser(withEmail: email, password: password) { result, error in
//                if let error = error  {
//                    print(error.localizedDescription)
//                    return
//                }
//
//                guard let user = result?.user else { return }
//                self.userSession = user
//                print("DEBUG: Successfully registered the user..")
//
//                let data = ["email": email, "username": username, "fullname": fullname, "profileImageURL": imageURL, "uid": user.uid]
//
//                COLLECTION_USERS.document(user.uid).setData(data) { _ in
//                    print("DEBUG: Successfully uploaded user data..")
//                    self.userSession = user
//                    self.fetchUser()
//                }
//            }
//        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error  {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            print("DEBUG: Successfully registered the user..")
            
            let data = ["email": email, "username": username, "fullname": fullname, "profileImageURL": "", "uid": user.uid]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("DEBUG: Successfully uploaded user data..")
                self.userSession = user
                self.fetchUser()
            }
        }
        
        
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword() {
        
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            
        }
    }
}
