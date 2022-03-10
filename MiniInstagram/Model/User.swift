//
//  User.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Decodable {
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String
    @DocumentID var id: String?
}
