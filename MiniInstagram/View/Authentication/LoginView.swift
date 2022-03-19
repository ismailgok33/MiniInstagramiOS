//
//  LoginView.swift
//  InstagramSwiftUITutorial
//
//  Created by Stephen Dowless on 12/27/20.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Image("login_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: getRect().width, height: (getRect().height / 2))
                    .foregroundColor(.white)
                    .ignoresSafeArea()
                
                
                VStack {
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 40) {
                        
                        Spacer()
                        
                        // Google Sign in
                        Button(action: {
                            viewModel.googleLogin()
                        }, label: {
                            HStack {
                                
                                Image("google_logo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipped()
                                
                                Text("Sign in with Google")
                                    .font(.headline)
                                    .foregroundColor(Color("text_header"))
                                //                                .frame(width: 300, height: 70)
                                
                            } //: HStack
                            .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("google_login_color"), lineWidth: 2)
                            )
                        })
                        
                        // Apple Sign in
                        SignInWithAppleButton { request in
                            viewModel.nonce = randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(viewModel.nonce)
                            
                        } onCompletion: { result in
                            
                            switch result {
                            case .success(let user):
                                print("DEBUG: successfully signed in with Apple")
                                // do login with Firebase
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else { print("DEBUG: error while Apple Signin with Firebase")
                                    return
                                }
                                viewModel.appleLogin(credential: credential)
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                            
                        }
                        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                        .frame(width: getRect().width - 30, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        // Facebook Sign in
                        Button(action: {
                            viewModel.googleLogin()
                        }, label: {
                            HStack {
                                
                                Image("facebook_logo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipped()
                                
                                Text("Sign in with Facebook")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            } //: HStack
                            .frame(width: getRect().width - 30, height: 70)
                            .background(Color("facebook_login_color"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        })
                        
                        
                        // Email Sign In
                        
//                        NavigationLink {
//                            EmailLoginView()
//                        } label: {
//                            Text("Sign in with your email")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .frame(width: UIScreen.main.bounds.width - 30, height: 70)
//                                .background(Color("email_login_color"))
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                        }
                        
                        // Sign Up navigation link
                        
//                        NavigationLink(
//                            destination: RegistrationView().navigationBarHidden(true),
//                            label: {
//                                HStack {
//                                    Text("Not a member?")
//                                        .font(.system(size: 18))
//                                        .foregroundColor(Color("text_header"))
//
//                                    Text("Signup now")
//                                        .font(.system(size: 18, weight: .semibold))
//                                        .foregroundColor(.blue)
//                                }
//                            }).padding(.bottom, 16)
                        
                        Spacer()
                        VStack {
                            
                            Image("app_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            .padding(.bottom, 24)
                        }

                    } //: VStack
                    .frame(maxWidth: .infinity)
                    .frame(height: getRect().height * 0.6)
                    .background(Color("background_color").cornerRadius(20))

                    
                }
                .background(Color.clear)
                .frame(maxWidth: .infinity)
                
            } //: ZStack
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    
    static func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        
        return root
    }
}
