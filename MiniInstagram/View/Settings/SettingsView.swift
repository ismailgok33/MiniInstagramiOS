//
//  SettingsView.swift
//  MiniInstagram
//
//  Created by İsmail on 17.03.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLogoutTapped: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("text_header"))
                }
                
                Spacer()

            }
            .padding()
            
            Spacer()
            
            Image("app_logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
            
            Spacer()
            
            
            VStack {
                
                logoutButton
                    .padding(.vertical)
                
                Link("Go to Website", destination: URL(string: "https://www.google.com")!)
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                
                Link("Privacy Policy", destination: URL(string: "https://www.google.com")!)
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                
                Link("Terms of Service", destination: URL(string: "https://www.google.com")!)
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
            }
            .foregroundColor(Color("text_header"))
            .frame(width: getRect().width, height: getRect().height / 3)
            .background(Color("background_color"))
            .ignoresSafeArea()
           
           
            
        } //: VStack
        .background(Color("background_color"))
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                BackButtonView(inProfileView: false)
//            }
//        }
    } //: body
    
    var logoutButton: some View {
        
        Button {
            isLogoutTapped = true
            presentationMode.wrappedValue.dismiss()
//            AuthViewModel.shared.signOut()
            
        } label: {
            Text("Logout")
                .font(.system(size: 22, weight: .semibold))
                .frame(width: 200, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Capsule())
                
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLogoutTapped: .constant(false))
            .preferredColorScheme(.dark)
    }
}
