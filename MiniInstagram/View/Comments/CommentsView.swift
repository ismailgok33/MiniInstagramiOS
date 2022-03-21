//
//  CommentsView.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @Environment(\.currentTab) var tab
    @State var commentText = ""
    @ObservedObject var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            // comment cells
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(viewModel: viewModel, comment: comment)
                    }
                }
            }
            .padding(.top)
            
            
            // input view
            CustomInputView(inputText: $commentText, action: uploadComment)
            
        } //: VStack
        
    } //: body
    
    func uploadComment() {
        viewModel.uploadComment(commentText: commentText)
        commentText = ""
        UIApplication.shared.endEditing()
    }
}

//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView()
//    }
//}
