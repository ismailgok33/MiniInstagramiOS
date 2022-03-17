//
//  LoginView.swift
//  InstagramSwiftUITutorial
//
//  Created by Stephen Dowless on 12/27/20.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    Image("login_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: getRect().width, height: (getRect().height / 2))
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    
                    Spacer()
                    
                    VStack(spacing: 40) {
                        Button(action: {
                            viewModel.googleLogin()
                        }, label: {
                            HStack {
                                
                                Image("google_logo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
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
//                            .background(Color("google_login_color"))
//                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            
                           
                        })
                                            
//                        Button(action: {
////                            viewModel.login(withEmail: email, password: password)
//
//                        }, label: {
//                            Text("Sign in with your email")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .frame(width: UIScreen.main.bounds.width - 30, height: 70)
//                                .background(Color.black)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                        })
                        
                        NavigationLink {
                            EmailLoginView()
                        } label: {
                            Text("Sign in with your email")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                                .background(Color("email_login_color"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }

                        
                        
                        NavigationLink(
                            destination: RegistrationView().navigationBarHidden(true),
                            label: {
                                HStack {
                                    Text("Not a member?")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("text_header"))
                                    
                                    Text("Signup now")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.blue)
                                }
                            }).padding(.bottom, 16)
                        
                        Image("app_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .padding(.bottom, 24)
                    } //: VStack
                    
                    
                    
                } //: VStack
                .background(Color("background_color"))
                .padding(.top, -44)
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
