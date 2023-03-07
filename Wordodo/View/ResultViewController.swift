//
//  ResultViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import UIKit

class ResultViewController: UIViewController {

    var trueCount = 0
    var falseCount = 0
    var scoreCount = 0
    
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        trueLabel.text = "Doğru sayısı: \(trueCount)"
        falseLabel.text = "Yanlış sayısı: \(falseCount)"
        scoreLabel.text = "Score: \(scoreCount)"

    }
    
    @IBAction func reQuiz(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
