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
    
    var didLike: Bool {
        return viewModel.post.didLike ?? false
    }
    
//    init(viewModel: FeedCellViewModel) {
//        self.viewModel = viewModel
//    }
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
        self.commentViewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                KFImage(URL(string: viewModel.post.ownerImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                VStack(alignment: .leading) {
                    Text(viewModel.post.ownerUsername)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Los Angeles")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.gray)
                } //: VStack
                
                Spacer()
                
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 24))
                    .padding(4)
                    .padding(.trailing, 6)
                
            } //: HStack
            .padding([.leading, .bottom], 8)
            
            // Image ZStack
            ZStack(alignment: .bottom) {
                // post images
                KFImage(URL(string: viewModel.post.imageURL))
//                Image("login_image")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 440)
                    .clipped()
                
                // action buttons
                    HStack(spacing: 16) {
                        
                        // Like HStack
                        HStack {
                            
                            Button {
                                didLike ? viewModel.unlike() : viewModel.like()
                            } label: {
//                                Image(systemName: didLike ? "heart.fill" : "heart")
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFill()
//                                    .foregroundColor(didLike ? .red : .black)
                                    .foregroundColor(.black)
                                    .frame(width: 24, height: 24)
                                    .font(.system(size: 24))
//                                    .padding(4)
                            }
                            
                            Text(viewModel.likesString)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.leading, 8)
                                .padding(.bottom, 2)
                            
                        } //: HStack
                        .frame(minWidth: 80, idealWidth: 80, maxWidth: 80, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
                        .background(
                            Color.white
                                .opacity(didLike ? 1 : 0)
                        )
                        .clipShape(Capsule())
                        
                        // Comment HStack
                        HStack {
                            
                            NavigationLink {
//                                CommentsView(post: viewModel.post)
                                FeedCellDetail(post: viewModel.post)
                            } label: {
                                Image(systemName: "bubble.right")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                                    .font(.system(size: 24))
//                                    .padding(4)
                            }
                            
                            Text("\(commentViewModel.comments.count)")
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.leading, 8)
                                .padding(.bottom, 2)
                            
                            
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
                            Image(systemName: "paperplane")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                                .font(.system(size: 24))
                                .padding(4)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .font(.system(size: 16))
                            .padding(4)

                    } //: HStack
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .padding(.horizontal)
                .background(
                    Color.gray
                        .opacity(0.5)
                )
                .clipShape(Capsule())
                .padding(.bottom)
                
            } //: ZStack
            
           
            
            // captions
//            HStack {
//                Text(viewModel.post.ownerUsername)
//                    .font(.system(size: 14, weight: .semibold))
//                + Text(" \(viewModel.post.caption)")
//                    .font(.system(size: 15))
//            } //: HStack
//            .padding(.horizontal, 8)
//
//            Text(viewModel.timestampString)
//                .font(.system(size: 14))
//                .foregroundColor(.gray)
//                .padding(.leading, 8)
//                .padding(.top, -2)
            
        } //: VStack
        
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: Post(id: "8rh7m8L89tLtvRoJnA8g", ownerUid: "Q2H6do32QwZAEltLso90BFMrXcc2", ownerUsername: "Tercih Kılavuuz", caption: "Google first post", likes: 1, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/miniinstagram-5b2c2.appspot.com/o/post_images%2FF933C413-8E8A-4462-ADC2-4505E602B9ED?alt=media&token=bb198ab4-92a5-4e1b-9aea-6cbf7db8feeb", timestamp: Timestamp(date: Date()), ownerImageURL: "https://lh3.googleusercontent.com/a/AATXAJyBx5qeCx2Q7WSZFutnj29lUWaALbCkUwfOxUl2=s96-c", didLike: false, user: nil))
    }
}
