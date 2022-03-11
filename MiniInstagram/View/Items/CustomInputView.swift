//
//  CustomInputView.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import SwiftUI

struct CustomInputView: View {
    
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            // divider
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            // HStack with send button and textfield
            HStack {
                TextField("Comment...", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }

            } //: HStack
            .padding(.bottom, 8)
            .padding(.horizontal)
            
        } //: VStack
        
    }
}

//struct CustomInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputView(inputText: .constant(""))
//    }
//}
