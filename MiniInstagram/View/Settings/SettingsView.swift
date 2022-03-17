//
//  SettingsView.swift
//  MiniInstagram
//
//  Created by İsmail on 17.03.2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            logoutButton
        } //: VStack
        .background(Color("background_color"))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView(inProfileView: false)
            }
        }
    } //: body
    
    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signOut()
        } label: {
            Text("Logout")
                .font(.system(size: 18, weight: .semibold))
                .frame(width: 200, height: 50)
                .background(Color("button_bg_blue"))
                .clipShape(Capsule())
                
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
