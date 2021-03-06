//
//  PostGridViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import SwiftUI

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var noPosts = false
    let config: PostGridConfiguration
    
    init(config: PostGridConfiguration) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorePagePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
    
    func fetchExplorePagePosts() {
        COLLECTION_POSTS.order(by: "likes", descending: true).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents else {
                self.noPosts = true
                return
            }
            self.posts = document.compactMap({ try? $0.data(as: Post.self) })
            
            if self.posts.isEmpty {
                self.noPosts = true
            }
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents else {
                self.noPosts = true
                return
            }
            let posts = document.compactMap({ try? $0.data(as: Post.self) })
            
            if posts.isEmpty {
                self.noPosts = true
            }
            
            self.posts = posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }) // sort for new post is top
        }
    }
}
