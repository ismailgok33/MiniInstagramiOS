//
//  EmailLoginView.swift
//  MiniInstagram
//
//  Created by İsmail on 12.03.2022.
//

import SwiftUI

struct EmailLoginView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        //                    VStack(spacing: 20) {
        //                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
        //                            .padding()
        //                            .background(Color(.init(white: 1, alpha: 0.15)))
        //                            .cornerRadius(10)
        //                            .foregroundColor(.white)
        //                            .padding(.horizontal, 32)
        //
        //                        CustomSecureField(text: $password, placeholder: Text("Password"))
        //                            .padding()
        //                            .background(Color(.init(white: 1, alpha: 0.15)))
        //                            .cornerRadius(10)
        //                            .foregroundColor(.white)
        //                            .padding(.horizontal, 32)
        //                    } //: VStack
                                                
        //                    HStack {
        //                        Spacer()
        //
        //                        NavigationLink(
        //                            destination: ResetPasswordView(email: $email),
        //                            label: {
        //                                Text("Forgot Password?")
        //                                    .font(.system(size: 13, weight: .semibold))
        //                                    .foregroundColor(.white)
        //                                    .padding(.top)
        //                                    .padding(.trailing, 28)
        //                            })
        //                    } //: HStack
    }
}

struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView()
    }
}
