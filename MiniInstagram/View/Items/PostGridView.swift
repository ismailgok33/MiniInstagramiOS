//
//  PostGridView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    let config: PostGridConfiguration
    @ObservedObject var viewModel: PostGridViewModel
    
    init(config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        
        if viewModel.posts.isEmpty && !viewModel.noPosts {
            VStack {
                Spacer()
                LoadingView()
                Spacer()
            }
            .frame(width: getRect().width)
//            .ignoresSafeArea()
        }
        else {
            LazyVGrid(columns: items, spacing: 2) {
                ForEach(viewModel.posts) { post in
                    NavigationLink {
    //                    FeedCell(viewModel: FeedCellViewModel(post: post))
                        FeedCell(post: post, deleteAction: nil)
                    } label: {
                        KFImage(URL(string: post.imageURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width)
                            .clipped()
                    }

                }
            }
        }
        
       
    }
}

//struct PostGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostGridView()
//    }
//}
