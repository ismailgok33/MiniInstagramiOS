//
//  EditProfileView.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Done")
                }
                
            } //: HStack
            .padding()
            
        } //: ZStack
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
