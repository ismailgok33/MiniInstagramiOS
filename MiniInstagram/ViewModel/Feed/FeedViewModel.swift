//
//  FeedViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    init() {
        fetchPosts()
    }
    
    // change it to fetch only followed user's posts
    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents else { return }
            self.posts = document.compactMap({ try? $0.data(as: Post.self) })
        }
    }
    
}

