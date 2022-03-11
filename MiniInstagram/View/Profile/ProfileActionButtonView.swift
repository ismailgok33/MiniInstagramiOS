//
//  ProfileActionButtonView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed: Bool {
        return viewModel.user.isFollowed ?? false
    }
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            // edit profile button
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
        }
        else {
            // follow and message button
            HStack {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                }
                .cornerRadius(3)
                
                Button {
                    
                } label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 173, height: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            } //: HStack
        }
    }
}

//struct ProfileActionButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileActionButtonView()
//    }
//}
