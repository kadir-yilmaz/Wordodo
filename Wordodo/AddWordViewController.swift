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
    
    
    @IBOutlet weak var wordEnLabel: UITextField!
    
    @IBOutlet weak var wordTrLabel: UITextField!
    
    
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let wordEn = wordEnLabel.text
        let wordTr = wordTrLabel.text
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
                
        
    }
    

}
