//
//  TextArea.swift
//  InstagramSwiftUITutorial
//
//  Created by Stephen Dowless on 12/31/20.
//

import SwiftUI
import UIKit

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            
            TextEditor(text: $text)
                .lineSpacing(10)
                .autocapitalization(.sentences)
                .disableAutocorrection(true)
                .padding(4)
                .foregroundColor(Color("text_header"))
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color("text_header"), lineWidth: 2)
        )
        .padding()
        .font(.body)
    }
}

