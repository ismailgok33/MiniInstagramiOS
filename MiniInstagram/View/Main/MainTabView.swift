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
                    .environment(\.currentTab, $selectedIndex)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem({
                        Image("search_icon")
                    }).tag(1)
                    .environment(\.currentTab, $selectedIndex)
                
                UploadPostView(tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem({
                        Image("post_icon")
                            .frame(width: 40, height: 40)
                    }).tag(2)
                    .environment(\.currentTab, $selectedIndex)
                
                NotificationsView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem({
                        Image("activity_icon")
                    }).tag(3)
                    .environment(\.currentTab, $selectedIndex)
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem({
                        Image("profile_icon")
                    }).tag(4)
                    .environment(\.currentTab, $selectedIndex)
            }
    //        .tint(.black)
            .accentColor(.black)
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Search"
        case 2: return "New Post"
        case 3: return "Activities"
        case 4: return "Profile"
        default: return ""
        }
    }
}

struct CurrentTabKey: EnvironmentKey {
    static var defaultValue: Binding<Int> = .constant(0)
}

extension EnvironmentValues {
    var currentTab: Binding<Int> {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
