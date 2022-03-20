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
        VStack {
            HStack {
                Spacer()
                
                Text("Search")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("text_header"))
                
                Spacer()
            } //: HStack
            .frame(height: 30)
            .padding(.vertical)
            .padding(.top, 30)
            
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
            } //: ScrollView
            
        } //: VStack
        
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
