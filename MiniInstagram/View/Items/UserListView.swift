//
//  UserListView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct UserListView: View {
    
    @Environment(\.currentTab) var tab
    @ObservedObject var viewModel: SearchViewModel
    @Binding var searchText: String
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    if user.isCurrentUser {
                        Button {
                            tab.wrappedValue = 4
                        } label: {
                            UserCell(user: user)
                                .padding(.leading)
                        }

                    }
                    else {
                        NavigationLink {
                            LazyView(ProfileView(user: user))
                        } label: {
                            UserCell(user: user)
                                .padding(.leading)
                        }
                    }
                    

                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView()
                }
            }
        }
    }
}
