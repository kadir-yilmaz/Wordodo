//
//  UpdateWordViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import Alamofire
import FirebaseAuth

class UpdateWordVC: UIViewController {
    
    @IBOutlet weak var wordEnTextField: UITextField!
    @IBOutlet weak var wordTrTextField: UITextField!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    static var gelenWordId: Int?
    static var gelenWordEn: String?
    static var gelenWordTr: String?
    static var gelenWordSentence: String?

    static var listName = ""
    
    var viewModel = UpdateWordViewModel()
    
    let userId = Auth.auth().currentUser!.uid

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordEnTextField.text = UpdateWordVC.gelenWordEn
        wordTrTextField.text = UpdateWordVC.gelenWordTr
        wordSentenceTextView.text = UpdateWordVC.gelenWordSentence
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        
        guard let wordEn = wordEnTextField.text, let wordTr = wordTrTextField.text, let wordSentence = wordSentenceTextView.text else {
            return
        }
        
        let wordId = UpdateWordVC.gelenWordId
        
        viewModel.updateWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, userId: userId, listName: UpdateWordVC.listName, wordId: wordId!) { error in
            self.navigationController?.popViewController(animated: true)
        }
         
    }
    
}
