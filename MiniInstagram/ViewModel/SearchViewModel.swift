//
//  SearchViewModel.swift
//  MiniInstagram
//
//  Created by İsmail on 10.03.2022.
//

import SwiftUI

enum UserListType {
    case all
    case followers
    case following
}

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    init(userListType: UserListType) {
        switch userListType {
        case .all:
            fetchUsers()
        case .followers:
            fetchFollowers()
        case .following:
            fetchFollowing()
        }
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
            
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullname.lowercased().contains(lowercasedQuery) ||
            $0.username.lowercased().contains(lowercasedQuery)
        })
    }
    
    // TODO: Add server side functions for that
    func fetchFollowers() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let followers = snapshot?.documents else { return }
                        
            followers.forEach { user in
                COLLECTION_USERS.document(user.documentID).getDocument(as: User.self) { result in
                    switch result {
                    case .success(let user):
                        self.users.append(user)
                    case .failure(let error):
                        print("DEBUG: Error when fetching followers \(error.localizedDescription)")
                    }
                    
                }
            }
            
        }
    }
    
    // TODO: Add server side functions for that
    func fetchFollowing() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
            guard let following = snapshot?.documents else { return }
            
            following.forEach { user in
                COLLECTION_USERS.document(user.documentID).getDocument(as: User.self) { result in
                    switch result {
                    case .success(let user):
                        self.users.append(user)
                    case .failure(let error):
                        print("DEBUG: Error when fetching followers \(error.localizedDescription)")
                    }
                    
                }
            }
            
        }
    }
    
}
