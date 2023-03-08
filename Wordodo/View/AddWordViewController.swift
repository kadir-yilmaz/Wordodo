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
        
        let wordEn = wordEnTextField.text
        let wordTr = wordTrTextField.text
        let wordSentence = wordSentenceTextView.text
        let userId = Auth.auth().currentUser?.uid
        
        let urlString = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/insertWord.php"
        
        let parameters: [String: Any] = [
            "word_en": wordEn ?? "",
            "word_tr": wordTr ?? "",
            "word_sentence": wordSentence ?? "",
            "user_id": userId!
        ]
        
        AF.request(urlString,method: .post,parameters: parameters).response { response in
            
            if let data  = response.data {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
        }
        
        if wordEnTextField.text != "" && wordTrTextField.text != "" {
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    

}
