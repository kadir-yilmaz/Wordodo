//
//  ViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 24.02.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .dark
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    self?.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
                    return
                }
                
                guard let user = Auth.auth().currentUser else {
                    return
                }
                
                if user.isEmailVerified {
                    // Kullanıcının hesabı doğrulanmış
                    self?.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                } else {
                    // Kullanıcının hesabı henüz doğrulanmamış
                    self?.makeAlert(titleInput: "Hata", messageInput: "Önce email'i doğrula")
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

