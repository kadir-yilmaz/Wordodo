//
//  SignInViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation
import FirebaseAuth

class SignInViewModel {
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else if let user = Auth.auth().currentUser, user.isEmailVerified {
                // Kullanıcının hesabı doğrulanmış
                completion(true, nil)
            } else {
                // Kullanıcının hesabı henüz doğrulanmamış
                completion(false, "Önce email'i doğrula")
            }
        }
    }

}
