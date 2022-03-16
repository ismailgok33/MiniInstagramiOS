//
//  UploadPostViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    @Published var isUploading = false
    
    func uploadPost(caption: String, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        isUploading = true
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageURL": imageURL,
                        "ownerUid": user.id ?? "",
                        "ownerImageURL": user.profileImageURL,
                        "ownerUsername": user.username] as [String:Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            self.isUploading = false
        }
    }
    
}
