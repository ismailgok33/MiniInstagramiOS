//
//  ContentView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            // if not logged in show login
            if viewModel.userSession == nil {
                LoginView()
            }
            else { // else show main interface
                MainTabView()
            }
        }
//        MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
