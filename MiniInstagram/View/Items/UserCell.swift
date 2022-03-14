//
//  UserCell.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    let user: User
    
    var body: some View {
        HStack {
            // image
//            Image("joker")
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            
            // VStack -> username, fullname
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                Text(user.fullname)
                      .font(.system(size: 14))
                      .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            } //: VStack
            
            Spacer()
            
        } //: HStack
    }
}
