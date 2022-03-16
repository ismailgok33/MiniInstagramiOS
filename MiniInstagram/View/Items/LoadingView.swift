//
//  LoadingView.swift
//  MiniInstagram
//
//  Created by İsmail on 15.03.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
//                .ignoresSafeArea()
                .opacity(0.8)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
