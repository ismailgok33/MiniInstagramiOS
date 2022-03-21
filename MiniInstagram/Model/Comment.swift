//
//  Comment.swift
//  MiniInstagram
//
//  Created by İsmail on 11.03.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let postOwnerUid: String
    let profileImageURL: String
    let commentText: String
    let timestamp: Timestamp
    let uid: String
    
    var user: User?
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var isCommentOwner: Bool {
        return uid == AuthViewModel.shared.userSession?.uid
    }
}
