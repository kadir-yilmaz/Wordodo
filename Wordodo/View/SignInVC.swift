//
//  ViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 24.02.2023.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                return
            }
            
        viewModel.signIn(email: email, password: password) { success, error in
            guard let user = Auth.auth().currentUser else {
                return
            }
            if success {
                if user.isEmailVerified {
                    // Kullanıcının hesabı doğrulanmış
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                } else {
                    // Kullanıcının hesabı henüz doğrulanmamış
                    self.makeAlert(titleInput: "Hata", messageInput: "Önce email'i doğrula")
                }
            } else if let error = error {
                // If there was an error, display an alert with the error message.
                self.makeAlert(titleInput: "Error", messageInput: error)
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

