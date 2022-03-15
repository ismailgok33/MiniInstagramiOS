//
//  ProfileHeaderView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
//    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                VStack {
                    Text("\(viewModel.user.stats?.followers ?? 0)")
                        .font(.system(size: 30, weight: .bold))
                    
                    Text("Followers")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                } //: VStack
                .frame(width: 80, alignment: .center)
                
                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(8)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .clipShape(Circle())
                    .offset(y: -70)
                
                VStack {
                    Text("\(viewModel.user.stats?.followings ?? 0)")
                        .font(.system(size: 30, weight: .bold))
                    
                    Text("Following")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                } //: VStack
                .frame(width: 80, alignment: .center)
                
                Spacer()
//
//                KFImage(URL(string: viewModel.user.profileImageURL))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 80, height: 80)
//                    .clipShape(Circle())
//                    .padding(.leading)
//
//                Spacer()
//
//                HStack(spacing: 16) {
//
//                    VStack {
//                        Text("\(viewModel.user.stats?.posts ?? 0)")
//                            .font(.system(size: 15, weight: .semibold))
//
//                        Text("Posts")
//                            .font(.system(size: 15))
//                    } //: VStack
//                    .frame(width: 80, alignment: .center)
//
//                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers", viewModel: SearchViewModel(userListType: .followers))
//                    UserStatView(value: viewModel.user.stats?.followings ?? 0, title: "Following", viewModel: SearchViewModel(userListType: .following))
//
//                } //: HStack
//                .padding(.trailing, 32)
                
            } //: HStack
            .frame(height: 140)
            .background(Color.white.cornerRadius(20))
            .padding(.vertical)
            
            
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 1)
            }
            
            HStack {
                Spacer()
                
                ProfileActionButtonView(viewModel: viewModel)
                
                Spacer()
                
            } //: HStack
            .padding(.top)
            
            
        } //: VStack
        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(true)
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}
