//
//  AddWordViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import FirebaseAuth
import Alamofire

class AddWordVC: UIViewController {
    
    @IBOutlet weak var wordEnTextField: UITextField!
    @IBOutlet weak var wordTrTextField: UITextField!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    let userId = Auth.auth().currentUser!.uid
    let viewModel = AddWordModelViewModel()
    static var listName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let wordEn = wordEnTextField.text, let wordTr = wordTrTextField.text, let wordSentence = wordSentenceTextView.text else {
            return
        }
        
        viewModel.addWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, userId: userId, listName: AddWordVC.listName) { error in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
