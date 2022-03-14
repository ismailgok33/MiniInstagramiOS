//
//  NotificationBannerViewModifier.swift
//  MiniInstagram
//
//  Created by İsmail on 13.03.2022.
//

import SwiftUI

struct NotificationBannerViewModifier: ViewModifier {
    @Binding var isPresented: Bool
        let action: (() -> Void)?

        func body(content: Content) -> some View {
            VStack(spacing: 0) {
                if isPresented {
                    NotificationView()
                        .animation(.easeInOut)
                        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        .onTapGesture {
                            self.isPresented = false
                        }
                }
            }
        }
}


extension View {
    func banner(isPresented: Binding<Bool>, action: (() -> Void)? = nil) -> some View {
        self.modifier(NotificationBannerViewModifier(isPresented: isPresented, action: action))
    }
}
