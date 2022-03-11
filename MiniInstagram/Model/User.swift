//
//  User.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String
    @DocumentID var id: String?
    var bio: String?
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        return AuthViewModel.shared.userSession?.uid == id
    }
}

struct UserStats: Decodable {
    let followings: Int
    let posts: Int
    let followers: Int
}
