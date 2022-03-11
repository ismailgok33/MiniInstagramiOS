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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack( spacing: 16) {
                    UserStatView(value: 1, title: "Post")
                    UserStatView(value: 2, title: "Followers")
                    UserStatView(value: 4, title: "Following")
                } //: HStack
                .padding(.trailing, 32)
                
            } //: HStack
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            Text("Gotham's Dark Knight | Billionare")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)
            
            HStack {
                Spacer()
                
                ProfileActionButtonView(viewModel: viewModel)
                
                Spacer()
                
            } //: HStack
            .padding(.top)
            
            
        } //: VStack
    }
}

//struct ProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeaderView()
//    }
//}
