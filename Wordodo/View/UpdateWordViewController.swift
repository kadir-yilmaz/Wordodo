//
//  UpdateWordViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import Alamofire
import FirebaseAuth

class UpdateWordViewController: UIViewController {
    
    @IBOutlet weak var wordEnTextField: UITextField!
    @IBOutlet weak var wordTrTextField: UITextField!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    static var gelenWordId: Int?
    static var gelenWordEn: String?
    static var gelenWordTr: String?
    static var gelenWordSentence: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordEnTextField.text = UpdateWordViewController.gelenWordEn
        wordTrTextField.text = UpdateWordViewController.gelenWordTr
        wordSentenceTextView.text = UpdateWordViewController.gelenWordSentence

    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        
        guard let wordEn = wordEnTextField.text, let wordTr = wordTrTextField.text, let wordSentence = wordSentenceTextView.text else {
            return
        }
        
        let wordId = UpdateWordViewController.gelenWordId
        
        WebService.shared.updateWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, wordId: wordId!) { error in
                if let error = error {
                    print("Error updating word: \(error.localizedDescription)")
                } else {
                    if !wordEn.isEmpty && !wordTr.isEmpty {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
         
        
    }
    
}
