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
    
    func fetchPosts() {
        COLLECTION_POSTS.getDocuments { snapshot, _ in
            guard let document = snapshot?.documents else { return }
            self.posts = document.compactMap({ try? $0.data(as: Post.self) })
        }
    }
    
}

