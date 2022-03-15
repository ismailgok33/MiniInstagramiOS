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
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .center) {
            
            // Header Image part
            GeometryReader { proxy -> AnyView in
                
                // Sticky Header
                let minY = proxy.frame(in: .global).minY
                
                DispatchQueue.main.async {
                    self.offset = minY
                }
                
                return AnyView(
                    ZStack {
                        Image("profile_header_background_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                            .cornerRadius(0)
                    } //: ZStack
                    // Stretch Header
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : 0)
                )
            }
            .frame(height: 100)
            
            
            // Profile Image
            HStack {
                
                Spacer()
                
                VStack {
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers", viewModel: SearchViewModel(userListType: .followers))
                } //: VStack
                .frame(width: 80, alignment: .center)
                .padding(.horizontal)
                .offset(y: -40)
                
                
                
                Spacer()
                
                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(4)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .clipShape(Circle())
                    .offset(y: -70)
                
                Spacer()
                
                VStack {
                    UserStatView(value: viewModel.user.stats?.followings ?? 0, title: "Following", viewModel: SearchViewModel(userListType: .following))
                } //: VStack
                .frame(width: 80, alignment: .center)
                .padding(.horizontal)
                .offset(y: -40)
                
                Spacer()
                
                
            } //: HStack
            .frame(height: 150)
            .background(Color.white.cornerRadius(20))
//            .padding(.top, -50)
            .offset(y: -50)
            
            VStack {
                Text(viewModel.user.fullname)
                    .font(.system(size: 30, weight: .bold))
                    
                
                if let bio = viewModel.user.bio {
                    Text(bio)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 20) {
                    
                    Image("location_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("Grenoble")
                    
                } //: HStack - location
                
                HStack {
                    Spacer()
                    
                    ProfileActionButtonView(viewModel: viewModel)
                    
                    Spacer()
                    
                } //: HStack (profile action buttons)
                
               
                
            } //: VStack inner
            .padding(.top, -120)
            
           
            
            
        } //: VStack
        .ignoresSafeArea(.all, edges: .top)
//        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(true)
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}
