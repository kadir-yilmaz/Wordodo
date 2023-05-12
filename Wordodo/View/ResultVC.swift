//
//  ResultViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import UIKit

class ResultVC: UIViewController {

    var trueCount = 0
    var falseCount = 0
    
    var unknownWords = [Word]()
    
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var unknownWordsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        trueLabel.text = "Doğru sayısı: \(trueCount)"
        falseLabel.text = "Yanlış sayısı: \(falseCount)"
        
        var wordsString = ""
        for word in unknownWords {
            let wordString = "\(word.wordEn!) = \(word.wordTr!)\n"
            wordsString.append(wordString)
        }
        unknownWordsTextView.text = wordsString

    }
    
    @IBAction func reQuiz(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
