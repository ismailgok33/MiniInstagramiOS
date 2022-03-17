//
//  FollowNotificationCell.swift
//  MiniInstagram
//
//  Created by İsmail on 17.03.2022.
//

import SwiftUI
import Kingfisher

struct FollowNotificationCell: View {
    
    @ObservedObject var viewModel: NotificationCellViewModel

    var isFollowed: Bool {
        return viewModel.notification.isFollowed ?? false
    }

    init(notification: Notification) {
        self.viewModel = NotificationCellViewModel(notification: notification)
    }
    
    var body: some View {
        
        if viewModel.notification.type == .follow {
            VStack {
                
                NavigationLink {
                    if let user = viewModel.notification.user {
                        LazyView(ProfileView(user: user))
                    }
                } label: {
                    KFImage(URL(string: viewModel.notification.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                
                
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow Back")
                        .font(.system(size: 12, weight: .semibold))
                        .frame(width: 90, height: 30)
                        .foregroundColor(.white)
                        .background(Color("button_bg_blue"))
                        .clipShape(Capsule())
                }

            } //: VStack
        }
        
    } //: body
}

//struct FollowNotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowNotificationCell()
//    }
//}
