//
//  SettingsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 25.02.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            //GIDSignIn.sharedInstance.signOut()
            self.performSegue(withIdentifier: "toVC", sender: nil)
        } catch  {
            print("error")
        }
    }
}
