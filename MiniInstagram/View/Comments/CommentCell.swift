//
//  CommentCell.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct CommentCell: View {
    var body: some View {
        HStack {
            Image("joker")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text("batman").font(.system(size: 14, weight: .semibold)) + Text(" some test comment for now").font(.system(size: 14))
            
            Spacer()
            
            Text("2m")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            
        } //: HStack
        .padding(.horizontal)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell()
    }
}
