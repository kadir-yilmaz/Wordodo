//
//  SignUpViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 25.02.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark


    }
    

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    return
                }
                
                // Doğrulama e-postasını gönder
                user.sendEmailVerification { error in
                    if let error = error {
                        self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
                        return
                    }
                    
                    // E-posta doğrulama mesajını kullanıcıya göster
                    self.makeAlert(titleInput: "Email Verification", messageInput: "Verification email sent. Please check your inbox and follow the instructions to verify your email address.")
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
