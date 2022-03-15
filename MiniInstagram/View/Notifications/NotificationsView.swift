//
//  NotificationsView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct NotificationsView: View {
    
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
                            .background(Color.white.cornerRadius(12))
                            .padding(.horizontal)
                    }
                    
                }
            }
            .padding(.top)
            
        }
        .background(Color(UIColor.systemGray6))
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
