//
//  ProfileActionButtonView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher

struct ProfileActionButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var showEditProfile = false
    
    var isFollowed: Bool {
        return viewModel.user.isFollowed ?? false
    }
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            // edit profile button
            Button {
                showEditProfile.toggle()
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(colorScheme == .dark ? .gray : .black)
//                    .padding(.vertical, 12)
//                    .padding(.horizontal, 40)
                    .background(
                        colorScheme == .dark ? Color.black : Color.white
                        
                    )
                    .clipShape(Capsule())
//                    .foregroundColor(.black)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 3)
//                            .stroke(Color.gray, lineWidth: 1)
//                    )
            }.sheet(isPresented: $showEditProfile) {
                
            } content: {
                EditProfileView(user: $viewModel.user)
            }

        }
        else {
            // follow button
            HStack {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 360, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.gray : Color("button_bg_blue"))
                        .clipShape(Capsule())
                }
                .cornerRadius(3)
            } //: HStack
        }
    }
}

//struct ProfileActionButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileActionButtonView()
//    }
//}
