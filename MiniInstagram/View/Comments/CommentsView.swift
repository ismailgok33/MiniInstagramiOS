//
//  CommentsView.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @State var commentText = ""
    
    var body: some View {
        VStack {
            // comment cells
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(0 ..< 10) { _ in
                        CommentCell()
                    }
                }
            }
            .padding(.top)
            
            
            // input view
            CustomInputView(inputText: $commentText, action: uploadComment)
            
        } //: VStack
        
    } //: body
    
    func uploadComment() {
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
