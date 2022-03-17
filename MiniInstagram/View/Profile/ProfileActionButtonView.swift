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
                    .frame(width: getRect().width / 2, height: 50)
                    .foregroundColor(.white)
//                    .background( Color("text_gray") )
                    .background(Color("button_bg_blue"))
                    .clipShape(Capsule())
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
                        .frame(width: getRect().width / 2, height: 50)
                        .foregroundColor(.white)
//                        .background(isFollowed ? Color("text_gray") : Color("button_bg_blue"))
                        .background(Color("button_bg_blue"))
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
