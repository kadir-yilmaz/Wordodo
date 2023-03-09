//
//  AddWordViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import FirebaseAuth
import Alamofire

class AddWordViewController: UIViewController {
    
    @IBOutlet weak var wordEnTextField: UITextField!
    @IBOutlet weak var wordTrTextField: UITextField!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        guard let wordEn = wordEnTextField.text, let wordTr = wordTrTextField.text, let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let wordSentence = wordSentenceTextView.text ?? ""
        
        WebService.shared.addWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, userId: userId) { error in
            if let error = error {
                print("Error adding word: \(error.localizedDescription)")
            } else {
                if !wordEn.isEmpty && !wordTr.isEmpty {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
    }
    

}
