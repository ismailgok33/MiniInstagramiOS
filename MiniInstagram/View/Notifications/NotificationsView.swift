//
//  NotificationsView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        
        VStack {
            // Follow notifications scroll view
            ScrollView(.horizontal) {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.notifications.filter({ $0.type == .follow })) { notification in
                        VStack {
                            FollowNotificationCell(notification: notification)
                                .padding(.horizontal)
                        } //: VStack
                    } //: ForEach
                } //: LazyVStack
            } //: ScrollView - follow
            
            // Like and post notifications scroll view
            ScrollView {
                
                Text("TODAY (\(viewModel.notifications.filter({ $0.type != .follow }).count))")
                    .font(.system(size: 16, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.notifications.filter({ $0.type != .follow })) { notification in
                        VStack {
                            NotificationCell(notification: notification)
                                .frame(height: 60)
                                .background(Color("tabbar_bg").cornerRadius(12))
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
                
            } //: ScrollView - like and posts
            
        } //: VStack
        .background(colorScheme == .dark ? Color("background_color") : Color("activity_bg_color"))
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarColor(colorScheme == .dark ? UIColor(named: "background_color") : UIColor(named: "activity_bg_color"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
            ToolbarItem(placement: .navigation) {
                Text("Activity")
                    .font(.title3)
                    .foregroundColor(Color("text_header"))
            }
        } //: toolbar
        
    } //: body
}



struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
