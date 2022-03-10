//
//  Extensions.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
