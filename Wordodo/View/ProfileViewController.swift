//
//  ProfileViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Kullanıcının mevcut kullanıcı adını görüntülemek için Firestore'dan verileri alın
                guard let userId = Auth.auth().currentUser?.uid else {
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("users").document(userId).getDocument { (document, error) in
                    if let document = document, document.exists {
                        let data = document.data()
                        let userName = data?["user_name"] as? String ?? ""
                        self.userNameTextField.text = userName
                    }
                }
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        // Kullanıcının girdiği yeni kullanıcı adını Firestore'da güncellemek için verileri kaydedin
        
        guard let userId = Auth.auth().currentUser?.uid, let newUserName = userNameTextField.text else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["user_name": newUserName]) { (error) in
            if let error = error {
                print("Error updating user name: \(error.localizedDescription)")
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    

}
