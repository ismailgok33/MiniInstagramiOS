//
//  UserCell.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            // image
            Image("joker")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            
            // VStack -> username, fullname
            VStack(alignment: .leading) {
              Text("Batman")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Bruce Wayne")
                      .font(.system(size: 14))
            } //: VStack
            
            Spacer()
            
        } //: HStack
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
