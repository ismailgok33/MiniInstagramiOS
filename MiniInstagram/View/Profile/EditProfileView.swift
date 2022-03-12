//
//  EditProfileView.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var bioText: String
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    @Environment(\.presentationMode) var mode
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    viewModel.saveUserData(bioText)
                } label: {
                    Text("Done").bold()
                }
                
            } //: HStack
            .padding()
            
            TextArea(text: $bioText, placeholder: "Add your bio...")
                .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                .padding(.vertical)
            
            Spacer()
            
        } //: VStack
        .onReceive(viewModel.$uploadComplete, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        })
        
    } //: body
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
