//
//  SignUpViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 25.02.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        viewModel.signUp(email: emailTextField.text!, password: passwordTextField.text!) { success, message in
            if success {
                // Kayıt işlemi başarılı, kullanıcıya mesaj göster
                self.makeAlert(titleInput: "Email Verification", messageInput: message ?? "")
            } else {
                // Kayıt işlemi başarısız, kullanıcıya hata mesajı göster
                self.makeAlert(titleInput: "Error", messageInput: message ?? "Error")
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
