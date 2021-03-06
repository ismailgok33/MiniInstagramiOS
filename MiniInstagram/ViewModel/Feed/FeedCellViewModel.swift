//
//  FeedCellViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var likesString: String {
        let label = post.likes > 999 ? "\(post.likes / 1000)k" : "\(post.likes)"
        return label
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
        checkIfUserFlaggedPost()
        fetchPostOwnerUser()
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).setData([:]) { _ in
                
                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                
                NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid, type: .like, post: self.post)
                
                self.post.didLike = true
                self.post.likes += 1
            }
        }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                
                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
                
                self.post.didLike = false
                self.post.likes -= 1
            }
        }
        
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.post.didLike = didLike
        }
    }
    
    func flag() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-flags").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-flags").document(postId).setData([:]) { _ in
                
//                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1])
                
//                NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid, type: .like, post: self.post)
                
                self.post.didFlag = true
//                self.post.likes += 1
            }
        }
    }
    
    func unFlag() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-flags").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-flags").document(postId).delete { _ in
                
//                COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1])
                
                self.post.didFlag = false
//                self.post.likes -= 1
            }
        }
    }
    
    func checkIfUserFlaggedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-flags").document(postId).getDocument { snapshot, _ in
            guard let didFlag = snapshot?.exists else { return }
            self.post.didFlag = didFlag
        }
    }
    
    func deletePost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        guard uid == post.ownerUid else { return }
        
        // Delete post document
        COLLECTION_POSTS.document(postId).delete { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.post.deleted = true
            print("DEBUG: the post successfully deleted.")
            
            // TODO: Check if I need to Delete subcollections of post
            
        }
    }
    
    func fetchPostOwnerUser() {
        guard let _ = AuthViewModel.shared.userSession?.uid else { return }
        guard let _ = post.id else { return }
        
        // fetch user object for that post
        COLLECTION_USERS.document(post.ownerUid).getDocument { snapshot, _ in
            guard let document = snapshot else { return }
            
            self.post.user = try? document.data(as: User.self)
//            print("DEBUG: Post user is \(self.post.user?.username)")
        }
    }
    
}

