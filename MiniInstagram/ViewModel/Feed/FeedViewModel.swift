//
//  FeedViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var noPosts = false
    
    init() {
        fetchPosts()
    }
    
    // change it to fetch only followed user's posts
    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents else {
                self.noPosts = true
                return
            }
            self.posts = document.compactMap({ try? $0.data(as: Post.self) })
            
            snapshot?.documentChanges.forEach({ doc in
                if doc.type == .removed {
                    let id = doc.document.documentID
                    
                    self.posts.removeAll { post -> Bool in
                        return post.id == id
                    }
                }
            })
        }
    }
    
    func deletePost(postId: String) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        let postId = uid else { return }
//        guard uid == post.ownerUid else { return }
        
        // TODO: check if the user is owner of the post before delete
        
        // Delete post document
        COLLECTION_POSTS.document(postId).delete { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.posts.removeAll { post -> Bool in
                return post.id == postId
            }
            
            print("DEBUG: the post successfully deleted.")
            
            // TODO: Check if I need to Delete subcollections of post
            
        }
    }
    
}

