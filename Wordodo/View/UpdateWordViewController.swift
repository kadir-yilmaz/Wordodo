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
                
        let parameters: [String: Any] = [
            "user_id": Auth.auth().currentUser!.uid,
            "word_id": wordId!,
            "word_en": wordEn,
            "word_tr": wordTr,
            "word_sentence": wordSentence
        ]
        
        AF.request("https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/updateWord.php", method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        if wordEnTextField.text != "" && wordTrTextField.text != "" {
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
}
