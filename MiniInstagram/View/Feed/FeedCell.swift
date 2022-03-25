//
//  FeedCell.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher
import Firebase

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    @Environment(\.presentationMode) var presentation
    @Environment(\.currentTab) var tab
    @State var showNotification = false
    
    var deleteAction: ((String) -> Void)?
    
    var didLike: Bool {
        return viewModel.post.didLike ?? false
    }
    
    var didFlag: Bool {
        return viewModel.post.didFlag ?? false
    }
    
    var isPostOwner: Bool {
        return viewModel.post.ownerUid == AuthViewModel.shared.currentUser?.id
    }
    
    //    init(viewModel: FeedCellViewModel) {
    //        self.viewModel = viewModel
    //    }
    
    init(post: Post, deleteAction: ((String) -> Void)?) {
        self.deleteAction = deleteAction
        self.viewModel = FeedCellViewModel(post: post)
        self.commentViewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack() {
            
            // user info
            HStack {
                
                if isPostOwner { // if the tapped user is the current user
                    
                    Button {
                        tab.wrappedValue = 4 // go to profile tab
                    } label: {
                        KFImage(URL(string: viewModel.post.ownerImageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .cornerRadius(18)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.post.ownerUsername)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color("text_header"))
                            
                            Text("Los Angeles")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color("text_gray"))
                        } //: VStack
                    }
                    
                }
                else { // if the tapped user is someone else
                    NavigationLink {
                        
                        if let user = viewModel.post.user {
                            LazyView(ProfileView(user: user))
                        }
                    } label: {
                        KFImage(URL(string: viewModel.post.ownerImageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipped()
                            .cornerRadius(18)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.post.ownerUsername)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color("text_header"))
                            
                            Text("Los Angeles")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color("text_gray"))
                        } //: VStack
                    }
                }
                
                
                
                Spacer()
                
                Menu {
                    if isPostOwner {
                        
                        Text("Edit")
                        
                        Button {
                            if let deleteAction = deleteAction {
                                deleteAction(viewModel.post.id ?? "")
                            }
                            else {
                                viewModel.deletePost()
                                presentation.wrappedValue.dismiss()
                                
                            }
                        } label: {
                            Text("Delete")
                        }
                        
                    }
                    else {
                        
                        Button {
                            self.showNotification = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.showNotification = false
                            }
                            
                        } label: {
                            Text("Report")
                        }
                    }
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                        .font(.system(size: 24))
                        .padding(4)
                        .padding(.trailing, 6)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                
                
            } //: HStack
            .padding([.leading, .bottom], 8)
            
            //            // Image ZStack
            //            ZStack() {
            //                // post images
            //                KFImage(URL(string: viewModel.post.imageURL))
            //                    .resizable()
            //                    .scaledToFill()
            //                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
            //                    .clipped()
            //
            //                // action buttons
            //                PostActionButtonView(viewModel: viewModel, commentViewModel: commentViewModel)
            //
            //            } //: ZStack
            
//            ZStack {
//                Spacer()
                
                KFImage(URL(string: viewModel.post.imageURL))
                    .resizable()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: getRect().width)
                    .scaledToFill()
                    .clipped()
                    .overlay(PostActionButtonView(viewModel: viewModel, commentViewModel: commentViewModel), alignment: .bottom)
//            } //: ZStack
            
        } //: VStack
        
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: Post(id: "8rh7m8L89tLtvRoJnA8g", ownerUid: "Q2H6do32QwZAEltLso90BFMrXcc2", ownerUsername: "Tercih Kılavuuz", caption: "Google first post", likes: 1, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/miniinstagram-5b2c2.appspot.com/o/post_images%2FF933C413-8E8A-4462-ADC2-4505E602B9ED?alt=media&token=bb198ab4-92a5-4e1b-9aea-6cbf7db8feeb", timestamp: Timestamp(date: Date()), ownerImageURL: "https://lh3.googleusercontent.com/a/AATXAJyBx5qeCx2Q7WSZFutnj29lUWaALbCkUwfOxUl2=s96-c", didLike: false, user: nil), deleteAction: nil)
            .preferredColorScheme(.light)
    }
}

struct PostActionButtonView: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    @Environment(\.presentationMode) var presentation
    
    var didLike: Bool {
        return viewModel.post.didLike ?? false
    }
    
    var didFlag: Bool {
        return viewModel.post.didFlag ?? false
    }
    
    var isPostOwner: Bool {
        return viewModel.post.ownerUid == AuthViewModel.shared.currentUser?.id
    }
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Like Button
                Button {
                    didLike ? viewModel.unlike() : viewModel.like()
                } label: {

                    HStack {
                        Image("post_like_icon")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                            .font(.system(size: 24))
                        //                                    .padding(4)
                        
                        Text(viewModel.likesString)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.leading, 8)
                            .padding(.bottom, 2)
                            .foregroundColor(Color("text_header"))
                    
                    } //: HStack
                    .frame(width: 80, height: 40)
                    .background(
                        Color("post_action_bg_active_color")
                            .opacity(didLike ? 1 : 0)
                            
                    )
                    .clipShape(Capsule())
                    
                    
                }
            
            
            // Comment HStack
            HStack {
                
                NavigationLink {
                    //                                CommentsView(post: viewModel.post)
                    FeedCellDetail(post: viewModel.post)
                } label: {
                    Image("post_comment_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24)
                        .font(.system(size: 24))
                    //                                    .padding(4)
                    
                    Text("\(commentViewModel.comments.count)")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.leading, 8)
                        .padding(.bottom, 2)
                        .foregroundColor(Color("text_header"))
                }
                
                
            } //: HStack
            .frame(minWidth: 80, idealWidth: 80, maxWidth: 80, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
            .background(
                Color.white
                //                                .opacity(didLike ? 1 : 0)
                    .opacity(0)
            )
            .clipShape(Capsule())
            
            
            Button {
                
            } label: {
                Image("post_message_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 24))
                    .padding(4)
            }
            
            Spacer()
            
            // Flag
            Button {
                didFlag ? viewModel.unFlag() : viewModel.flag()
            } label: {
                Image("post_bookmark_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 24))
                    .padding(4)
                    .foregroundColor(didFlag ? .white : .black)
            }
            .background(
                Color("post_action_bg_active_color")
                    .opacity(didFlag ? 1 : 0)
            )
            .clipShape(Circle())
            
            
            
        } //: HStack
        //        .foregroundColor(.black)
        .frame(width: getRect().width - 50, height: 50)
        .padding(.horizontal)
        .background( Color("post_action_bg_color") )
        .clipShape(Capsule())
        .padding(.bottom)
    }
}
