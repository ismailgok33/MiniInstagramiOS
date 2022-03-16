//
//  FeedView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        
        if viewModel.posts.isEmpty && !viewModel.noPosts {
            LoadingView()
        }
        else {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
    //                    FeedCell(viewModel: FeedCellViewModel(post: post))
                        FeedCell(post: post, deleteAction: deletePost)
                    }
                }
                .padding(.top)
            }
            .onAppear {
                viewModel.fetchPosts()
            }
        }
        
        
    } //: body
        
    
    func deletePost(postId: String) {
        viewModel.deletePost(postId: postId)
    }
    
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
