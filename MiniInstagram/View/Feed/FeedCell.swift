//
//  FeedCell.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool {
        return viewModel.post.didLike ?? false
    }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                KFImage(URL(string: viewModel.post.ownerImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
            } //: HStack
            .padding([.leading, .bottom], 8)
            
            // post images
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 440)
                .clipped()
                
            
            // action buttons
            HStack(spacing: 16) {
                Button {
                    didLike ? viewModel.unlike() : viewModel.like()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                NavigationLink {
                    CommentsView(post: viewModel.post)
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }

                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                }

            } //: HStack
            .foregroundColor(.black)
            .padding(.leading, 4)
            
            
            // captions
            Text(viewModel.likesString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            HStack {
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
                + Text(" \(viewModel.post.caption)")
                    .font(.system(size: 15))
            } //: HStack
            .padding(.horizontal, 8)
            
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top, -2)
            
        } //: VStack
        
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell()
//    }
//}
