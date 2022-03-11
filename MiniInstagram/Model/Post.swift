//
//  Post.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageURL: String
    let timestamp: Timestamp
    let ownerImageURL: String
    
    var didLike: Bool? = false
    var user: User?
}
