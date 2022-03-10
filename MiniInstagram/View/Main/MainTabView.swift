//
//  MainTabView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem({
                        Image(systemName: "house")
                    })
                
                SearchView()
                    .tabItem({
                        Image(systemName: "magnifyingglass")
                    })
                
                UploadPostView()
                    .tabItem({
                        Image(systemName: "plus.square")
                    })
                
                NotificationsView()
                    .tabItem({
                        Image(systemName: "heart")
                    })
                
                ProfileView()
                    .tabItem({
                        Image(systemName: "person")
                    })
            }
    //        .tint(.black)
            .accentColor(.black)
            .navigationTitle("Home")
//            .navigationBarItems(leading: logoutButton)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                            logoutButton
                        }
                    }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var logoutButton: some View {
        Button {
            AuthViewModel.shared.signOut()
        } label: {
            Text("Logout").foregroundColor(.black)
        }

    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
