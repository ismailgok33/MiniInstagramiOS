//
//  LazyView.swift
//  InstagramSwiftUITutorial
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
