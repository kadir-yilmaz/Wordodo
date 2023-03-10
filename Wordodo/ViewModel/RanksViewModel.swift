//
//  RanksViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation
import FirebaseFirestore

class RanksViewModel {
    
    var users = [User]()
    
    func fetchUsers(completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                completion(error)
                return
            }
            
            self.users = documents.map { document in
                let data = document.data()
                let userName = data["user_name"] as? String ?? "Unknown"
                let userScore = data["user_score"] as? Int ?? 0
                return User(userName: userName, userScore: userScore)
            }.sorted(by: { $0.userScore! > $1.userScore! })
            
            completion(nil)
        }
    }
}
