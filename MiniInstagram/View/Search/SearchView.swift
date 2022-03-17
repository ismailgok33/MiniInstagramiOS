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
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            // search bar
            SearchBar(text: $searchText, isEditing: $isSearchMode)
                .padding()
            
            // grid view
            ZStack {
                if isSearchMode {
                    UserListView(viewModel: viewModel, searchText: $searchText)
                }
                else {
                    PostGridView(config: .explore)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
