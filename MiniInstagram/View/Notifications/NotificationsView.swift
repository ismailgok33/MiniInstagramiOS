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
        ScrollView {
            
            Text("TODAY (\(viewModel.notifications.count))")
                .font(.system(size: 16, weight: .semibold))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack(spacing: 12) {
                ForEach(viewModel.notifications) { notification in
                    VStack {
                        NotificationCell(notification: notification)
                            .frame(height: 60)
                            .background(Color("tabbar_bg").cornerRadius(12))
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
            
        }
        .background(colorScheme == .dark ? Color("background_color") : Color("activity_bg_color"))
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
                    }
            ToolbarItem(placement: .navigation) {
                Text("Activity")
                    .font(.title3)
                    .foregroundColor(Color("text_header"))
            }
                }
//        .navigationBarItems(leading: btnBack)
    }
}



struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
