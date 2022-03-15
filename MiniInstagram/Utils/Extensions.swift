//
//  Extensions.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        
        return root
    }
}
