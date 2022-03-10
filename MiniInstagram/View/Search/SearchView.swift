//
//  SearchView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @State var isSearchMode = false
    
    var body: some View {
        ScrollView {
            // search bar
            SearchBar(text: $searchText, isEditing: $isSearchMode)
                .padding()
            
            // grid view
            ZStack {
                if isSearchMode {
                    UserListView()
                }
                else {
                    PostGridView()
                }
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
