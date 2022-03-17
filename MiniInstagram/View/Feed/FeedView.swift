//
//  FeedView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct FeedView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center, spacing: 5) {
                
                Image("app_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .padding(4)
                
                Text("Photos")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("text_header"))
//                    .foregroundColor(colorScheme == .dark ? .gray : .black)
                
                Spacer()

                // Search Button
                NavigationLink {
                    SearchView()
                } label: {
                    Image("search_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 26, height: 26)
                }
                .padding(.horizontal, 4)
                
                // Activity Button
                NavigationLink {
                    NotificationsView()
                } label: {
                    Image("activity_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 26, height: 26)
                }
                .padding(.horizontal, 4)
                
                // Message Button
                Button(action: {
                    // Go to message screen
                }, label: {
                    Image("message_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 26, height: 26)
                })
                .padding(.horizontal, 4)
                
            } //: HStack
            .padding(.horizontal)
            
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
                    } //: LazyVStack
                    .padding(.top)
                } //: ScrollView
                .onAppear {
                    viewModel.fetchPosts()
                }
            }
        } //: VStack
        .navigationBarHidden(true)
        
        
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
