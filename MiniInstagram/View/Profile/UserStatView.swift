//
//  UserStatView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    @ObservedObject var viewModel: SearchViewModel
    @State var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        if value == 0 {
            VStack {
                Text("\(value)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                Text("\(title)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            } //: VStack
        }
        else {
            NavigationLink {
                UserListView(viewModel: viewModel, searchText: $searchText)
            } label: {
                VStack {
                    Text("\(value)")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
                    Text("\(title)")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                } //: VStack
//                .frame(width: 80, alignment: .center)
            }

        }
        
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 1, title: "Post", viewModel: SearchViewModel())
    }
}
