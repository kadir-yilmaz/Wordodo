//
//  ProfileViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUserName { (userName) in
            self.userNameTextField.text = userName
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
