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
//                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
                
                VStack {
                    Image("login_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 2))
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
                                    .foregroundColor(.white)
    //                                .frame(width: 300, height: 70)
                                    
                            } //: HStack
                            .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                            .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            
                           
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
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }

                        
                        
                        NavigationLink(
                            destination: RegistrationView().navigationBarHidden(true),
                            label: {
                                HStack {
                                    Text("Not a member?")
                                        .font(.system(size: 18))
                                        .foregroundColor(.black)
                                    
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
