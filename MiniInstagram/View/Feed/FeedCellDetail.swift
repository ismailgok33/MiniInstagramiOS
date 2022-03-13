//
//  FeedCellDetail.swift
//  MiniInstagram
//
//  Created by İsmail on 12.03.2022.
//

import SwiftUI
import Firebase
import Kingfisher

struct FeedCellDetail: View {
    
    @ObservedObject var feedViewModel: FeedCellViewModel
    @ObservedObject var commentViewModel: CommentViewModel
    @State var commentText = ""
    @State var cardShown = false
    @State var cardDismissal = false
    
    init(post: Post) {
        self.feedViewModel = FeedCellViewModel(post: post)
        self.commentViewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        ZStack {
            VStack {
                // Feed Cell
    //            FeedCell(viewModel: feedViewModel)
                FeedCell(post: feedViewModel.post, deleteAction: nil)
                
                // Who liked the post
                HStack {
                
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        
                        Text("Liked by")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("Sean, John,")
                            .font(.system(size: 14, weight: .bold))
                        + Text("and 120 others")
                            .font(.system(size: 14, weight: .regular))
                        
                    } //: VStack
                    
                    Spacer()
                    
                } //: HStack
                .padding()
                
                // Comment Cell
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 24) {
                        ForEach(commentViewModel.comments) { comment in
                            CommentCell(viewModel: commentViewModel, comment: comment)
                        }
                        .onDelete(perform: deleteComment)
                    }
                }
                .padding(.top)
                .frame(width: UIScreen.main.bounds.width)
                .background(
                    Color.gray
                    .opacity(0.1)
                )
                .ignoresSafeArea(.all, edges: [.bottom])
                .padding(.top)
                
                // input view
                CustomInputView(inputText: $commentText, action: uploadComment)
                
            } //: VStack
            
            // Action Sheet (Bottom card view)
//            BottomCardView(cardShown: $cardShown, cardDismissal: $cardDismissal, height: UIScreen.main.bounds.height / 5) {
//                CardContent()
//                    .padding()
//            }
//            BottomCardView(cardShown: $cardShown, cardDismissal: $cardDismissal, height: UIScreen.main.bounds.height / 5, post: feedViewModel.post, commentUid: "")
//            .animation(.default)
            
        } //: ZStack
        
        
        
    } //: body
    
    func uploadComment() {
        commentViewModel.uploadComment(commentText: commentText)
        commentText = ""
    }
    
    func deleteComment(at offset: IndexSet) {
        let index = offset[offset.startIndex]
        let commentId = commentViewModel.comments[index].uid
        commentViewModel.deleteComment(uid: commentId)
    }
    
}

struct FeedCellDetail_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellDetail(post: Post(id: "8rh7m8L89tLtvRoJnA8g", ownerUid: "Q2H6do32QwZAEltLso90BFMrXcc2", ownerUsername: "Tercih Kılavuuz", caption: "Google first post", likes: 1, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/miniinstagram-5b2c2.appspot.com/o/post_images%2FF933C413-8E8A-4462-ADC2-4505E602B9ED?alt=media&token=bb198ab4-92a5-4e1b-9aea-6cbf7db8feeb", timestamp: Timestamp(date: Date()), ownerImageURL: "https://lh3.googleusercontent.com/a/AATXAJyBx5qeCx2Q7WSZFutnj29lUWaALbCkUwfOxUl2=s96-c", didLike: false, user: nil))
    }
}
