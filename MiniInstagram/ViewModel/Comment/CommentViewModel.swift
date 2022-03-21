//
//  CommentViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    private let post: Post
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        let data: [String : Any] = ["username": user.username,
                    "profileImageURL": user.profileImageURL,
                    "uid": user.id ?? "",
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerUid": post.ownerUid,
                    "commentText": commentText]
        
        COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data) { error in
            if let error = error {
                print("DEBUG: Error uploading comment \(error.localizedDescription)")
                return
            }
            
            NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid, type: .comment, post: self.post)
        }
    }
    
    func deleteComment(commentId: String) {
        guard let _ = AuthViewModel.shared.currentUser else { return }
        
        // if the user is not the comment owner, don't delete
//        guard user.id == uid else { return }
        
        // TODO: Check if the user is the same with the comment owner before delete
        
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-comments").document(commentId).delete { error in
            if let error = error {
                print("DEBUG: Error removing document: \(error.localizedDescription)")
                return
            }
                
            self.comments.removeAll { comment -> Bool in
                return comment.id == commentId
            }
            
            print("DEBUG: Document with id \(commentId) successfully removed!")
            
        }
    }
    
    func fetchComments() {
        guard let postId = post.id else { return }
        
        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comment.self)})
            )
        }
    }
}
