//
//  SignUpViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel {
    
    func signUp(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                completion(false, error?.localizedDescription ?? "Error")
                return
            }
            
            // Doğrulama e-postasını gönder
            user.sendEmailVerification { error in
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                
                // E-posta doğrulama mesajını kullanıcıya göster
                completion(true, "Verification email sent. Please check your inbox and follow the instructions to verify your email address.")
            }
            
            let db = Firestore.firestore()
            let userDocRef = db.collection("users").document(user.uid)
            userDocRef.setData(["user_id": user.uid, "user_name": "user_\(Int.random(in: 1...100000))"])
        }
    }
    
}
