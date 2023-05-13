//
//  ProfileViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel {
    
    let userId = Auth.auth().currentUser?.uid
    
    func fetchUserName(completion: @escaping (String) -> Void) {
        var user_name = "Name"
        let db = Firestore.firestore()
        db.collection("users").document(userId!).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let userName = data?["user_name"] as? String ?? ""
                user_name = userName
            }
            completion(user_name)
        }
    }

    
    func updateUserName(_ newUserName: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["user_name": newUserName]) { (error) in
            if let error = error {
                print("Error updating user name: \(error.localizedDescription)")
            } else {
                // Kullanıcı adı başarıyla güncellendiğinde bildirim gönder
            }
        }
    }
}
