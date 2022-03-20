//
//  AuthViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn
import CryptoKit
import AuthenticationServices

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User? // used for using User Info in the profile and other screens
    @Published var nonce = ""
    
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
                                
                COLLECTION_USERS.document(user.uid).setData(data as [String : Any]) { _ in
                    print("DEBUG: Successfully uploaded user data..")
                    self.userSession = user
                    self.fetchUser()
                }
            }
            
        }
    }
    
    func appleLogin(credential: ASAuthorizationAppleIDCredential) {
        
        // get Token
        guard let token = credential.identityToken else {
            print("DEBUG: error while getting Apple Sign in Token")
            return
        }
        
        // get Token String
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("DEBUG: error while creating Apple Sign in Token String")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // User successfully logged in to the app using Apple Sign in
            print("DEBUG: User successfully logged in to the app using Apple Sign in...")
            
            guard let user = result?.user else { return }
            
            let data = ["email": user.email, "username": user.displayName, "fullname": user.displayName, "profileImageURL": user.photoURL?.absoluteString, "uid": user.uid]
            
//                self.userSession = user
//                self.fetchUser()
                            
            COLLECTION_USERS.document(user.uid).setData(data as [String : Any]) { _ in
                print("DEBUG: Successfully uploaded user data..")
                self.userSession = user
                self.fetchUser()
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

// helpers for Apple Sign in with Firebase

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}
