//
//  BackButtonView.swift
//  MiniInstagram
//
//  Created by İsmail on 17.03.2022.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var inProfileView = false
    
    init(inProfileView: Bool = false) {
        self.inProfileView = inProfileView
    }

    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            if inProfileView {
                Image("profile_back_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 26)
            }
            else {
                Image("back_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 26)
            }
        }

    }
}

//struct BackButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackButtonView()
//    }
//}
