//
//  NotificationView.swift
//  MiniInstagram
//
//  Created by İsmail on 13.03.2022.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Your report has been sent!")
                .font(.system(size: 15))
                .bold()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                .background(Color(UIColor.systemGray))
            .cornerRadius(20)
            
            Spacer()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
