//
//  MainTabView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    @Binding var selectedIndex: Int
    
    init(user: User, selectedIndex: Binding<Int>) {
        self.user = user
        self._selectedIndex = selectedIndex
        UITabBar.appearance().backgroundColor = UIColor(named: "tabbar_bg")
     }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem({
                        Image("feed_icon")
                    }).tag(0)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem({
                        Image("reels_icon")
                    }).tag(1)
                
                UploadPostView(tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem({
                        Image("post_icon")
                    }).tag(2)
                
                NotificationsView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem({
                        Image("shop_icon")
                    }).tag(3)
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem({
                        Image("profile_icon")
                    }).tag(4)
            }
    //        .tint(.black)
            .accentColor(.black)
            .navigationTitle(tabTitle)
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
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New Post"
        case 3: return "Notifications"
        case 4: return "Profile"
        default: return ""
        }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
