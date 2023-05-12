//
//  QuizViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import UIKit
import Alamofire
import FirebaseAuth
import FirebaseFirestore
import GoogleMobileAds

class QuizVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var wordEnLabel: UILabel!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    static var url1 = ""
    static var url2 = ""

    var questions = [Word]()
    var choices = [Word]()
    var wrongChoices = [Word]()
    var question = Word()
    
    var questionCounter = 0
    var trueCounter = 0
    var falseCounter = 0
    
    var counter = 60
    
    var unknownWords = [Word]()
    
    var viewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.runTimer {
            self.countDown()
        }
        
        loadWords()
        viewModel.loadAd()

    }
    
    @objc func countDown(){
        
        timeLabel.text = "\(counter)"
        counter -= 1
        
        if counter == -1 {
            
            viewModel.timer.invalidate()
            
            if viewModel.interstitial != nil {
                viewModel.interstitial?.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }
            
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
        
    }
   
    func loadWords() {
        WebService.shared.fetchWords(url: QuizVC.url1) { [weak self] words in
            self?.questions = words
            DispatchQueue.main.async {
                self?.loadQuestion()
            }
        }
    }

    func getWrongWords(forWordId wordId: Int) {
        WebService.shared.getWrongWords(forWordId: wordId, from: QuizVC.url2) { words, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let words = words {
                self.wrongChoices = words
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.choices.removeAll()
                    self.choices.append(self.wrongChoices[0])
                    self.choices.append(self.wrongChoices[1])
                    self.choices.append(self.wrongChoices[2])
                    self.choices.append(self.question)
                    self.choices.shuffle()

                    self.buttonA.setTitle(self.choices[0].wordTr, for: .normal)
                    self.buttonB.setTitle(self.choices[1].wordTr, for: .normal)
                    self.buttonC.setTitle(self.choices[2].wordTr, for: .normal)
                    self.buttonD.setTitle(self.choices[3].wordTr, for: .normal)
                }
            }
        }
    }

    func loadQuestion() {
        trueLabel.text = "Doğru : \(trueCounter)"
        falseLabel.text = "Yanlış : \(falseCounter)"
        
        question = questions[questionCounter]
        wordEnLabel.text = question.wordEn
        
        if let wordId = self.question.wordId, let id = Int(wordId) {
            self.getWrongWords(forWordId: id)
        } else {
            print("wordId değeri nil!")
        }
    }
    
    @IBAction func buttonAClicked(_ sender: Any) {
        trueCheck(button: buttonA)
        questionCounterCheck()
    }
    
    
    @IBAction func buttonBClicked(_ sender: Any) {
        trueCheck(button: buttonB)
        questionCounterCheck()
    }
    
    
    @IBAction func buttonCClicked(_ sender: Any) {
        trueCheck(button: buttonC)
        questionCounterCheck()
    }
    
    
    @IBAction func buttonDClicked(_ sender: Any) {
        trueCheck(button: buttonD)
        questionCounterCheck()
    }
    
    func trueCheck(button:UIButton){
        
        let choice = button.titleLabel?.text
        let answer = question.wordTr
        
        if answer == choice {
            trueCounter += 1
        }else{
            falseCounter += 1
            unknownWords.append(question)
        }
        
        trueLabel.text = "Doğru : \(trueCounter)"
        falseLabel.text = "Yanlış : \(falseCounter)"
        
    }
    
    func questionCounterCheck(){
        questionCounter += 1
        
        if questionCounter != questions.count {
            loadQuestion()
        }else{
            counter = 0
            performSegue(withIdentifier: "toResultVC", sender: nil)
            if viewModel.interstitial != nil {
                viewModel.interstitial?.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destination = segue.destination as! ResultVC
            destination.trueCount = trueCounter
            destination.falseCount = falseCounter
            destination.unknownWords = unknownWords

        }
    }
    
}

extension QuizVC: GADFullScreenContentDelegate {
        
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
    }

}
