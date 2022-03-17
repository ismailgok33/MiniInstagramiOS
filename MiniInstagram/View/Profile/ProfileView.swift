//
//  ProfileView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        if viewModel.fetchingStats {
            LoadingView()
        }
        else {
            ScrollView {
                VStack(spacing: 32) {
                    ProfileHeaderView(viewModel: viewModel)
                    
                    PostGridView(config: .profile(user.id ?? ""))
                } //: VStack
                .padding(.top)
            }
            .background(Color("background_color"))
            
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
