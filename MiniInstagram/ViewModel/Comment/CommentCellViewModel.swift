//
//  CommentCellViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 20.03.2022.
//

import SwiftUI

class CommentCellViewModel: ObservableObject {
    @Published var comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
        fetchCommentOwner()
    }
    
    func fetchCommentOwner() {
        COLLECTION_USERS.document(comment.uid).getDocument { snapshot, _ in
            self.comment.user = try? snapshot?.data(as: User.self)
//            print("DEBUG: Comment User is \(self.comment.user?.username)")
        }
    }
}
