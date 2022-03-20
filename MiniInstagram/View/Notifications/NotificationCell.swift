//
//  NotificationCell.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher
import Firebase

struct NotificationCell: View {
    
    @State private var showPostImage = true
    @ObservedObject var viewModel: NotificationCellViewModel
    
    var isFollowed: Bool {
        return viewModel.notification.isFollowed ?? false
    }
    
    init(notification: Notification) {
        self.viewModel = NotificationCellViewModel(notification: notification)
    }
    
    var body: some View {
        // user info
        HStack {
            if let user = viewModel.notification.user {
                if viewModel.notification.type != .follow {
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        KFImage(URL(string: viewModel.notification.profileImageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.notification.username).foregroundColor(Color("text_header"))
                                .font(.system(size: 14, weight: .semibold))
                            + Text(viewModel.notification.type.notificationMessage).foregroundColor(Color("text_gray"))
                                .font(.system(size: 15))
                            + Text(" \(viewModel.timestampString)").foregroundColor(Color("text_gray"))
                                .font(.system(size: 12))
                                
                        } //: VStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                            
                    }
                }
            }
            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink {
//                        FeedCell(post: post, deleteAction: nil)
                        FeedCellDetail(post: post)
                    } label: {
                        KFImage(URL(string: post.imageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                }
            }
            
        } //: HStack
        .padding(.horizontal, 4)
        
    }
}

//struct NotificationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationCell(notification: Notification(username: "Tercih Kılavuuz", profileImageURL: "https://lh3.googleusercontent.com/a/AATXAJyBx5qeCx2Q7WSZFutnj29lUWaALbCkUwfOxUl2=s96-c", timestamp: Timestamp(date: Date()), type: .like, uid: "1DCYEY0y2WarZUKpOD4KLAXqStT2"))
//    }
//}

