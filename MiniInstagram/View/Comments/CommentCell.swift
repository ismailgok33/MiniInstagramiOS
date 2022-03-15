//
//  CommentCell.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI
import Kingfisher
import Firebase
import gRPC_Core

struct CommentCell: View {
    
    let comment: Comment
//    @Binding var cardShown: Bool
//    @Binding var cardDismissal: Bool
    @ObservedObject var viewModel: CommentViewModel
    
    init(viewModel: CommentViewModel, comment: Comment) {
        self.viewModel = viewModel
        self.comment = comment
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(comment.username).font(.system(size: 14, weight: .semibold)) + Text(" \(comment.commentText)").font(.system(size: 14))
            
            Text(" \(comment.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            
            Spacer()
            
            if comment.isCommentOwner {
                Menu {
                    
                    Button {
                        
                        viewModel.deleteComment(commentId: comment.id ?? "")
                        
                    } label: {
                        Text("Delete")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red)
                    }

                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }

                
            }
            
            Button {
                // like comment action
            } label: {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
    //                .clipped()
            }

            
           
            
        } //: HStack
        .padding(.horizontal)
        
    }
}

//struct CommentCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCell(comment: Comment(username: "Tercih Kılavuuz", postOwnerUid: "Q2H6do32QwZAEltLso90BFMrXcc2", profileImageURL: "https://lh3.googleusercontent.com/a/AATXAJyBx5qeCx2Q7WSZFutnj29lUWaALbCkUwfOxUl2=s96-c", commentText: "Google first comment", timestamp: Timestamp(date: Date()), uid: "Q2H6do32QwZAEltLso90BFMrXcc2"), cardShown: .constant(false), cardDismissal: .constant(false))
//    }
//}
