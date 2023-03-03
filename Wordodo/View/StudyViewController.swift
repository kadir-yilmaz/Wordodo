//
//  StudyViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit
import Alamofire
class StudyViewController: UIViewController {

    var words: [Word] = []
    var currentWordIndex = 0
    var wordCard: WordCardView!

    
    @IBOutlet weak var wordOrderLabel: UILabel!
    
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
        
        wordCard = WordCardView(frame: CGRect(x: 50, y: 200, width: 300, height: 200))
        view.addSubview(wordCard)
        


    }
    
    func loadWords() {
        
        AF.request("https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php",method: .get).response{
            response in
            
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(JSONResponse.self, from: data)
                    
                    if let gelenKelimeListesi = cevap.words{
                        self.words = gelenKelimeListesi
                    }
                    
                    self.updateWordCard()

                    DispatchQueue.main.async {
                        self.updateWordCard()
                        print(self.words.count)
                        self.wordOrderLabel.text = "\(self.currentWordIndex + 1) / \(self.words.count)"

                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }

    }
    
    func updateWordCard() {
        guard !self.words.isEmpty else {
            return
        }
        let word = self.words[currentWordIndex]
        self.wordCard.wordLabel.text = word.wordEn
        self.wordCard.meaningLabel.text = word.wordTr
        let orderText = "\(currentWordIndex+1)/\(self.words.count)"
        self.wordSentenceTextView.text = word.wordSentence

    }

    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentWordIndex < words.count - 1 {
                    currentWordIndex += 1
                    updateWordCard()
            wordOrderLabel.text = "\(currentWordIndex + 1) / \(words.count)"

                }
    }
    
    
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        if currentWordIndex > 0 {
                   currentWordIndex -= 1
                   updateWordCard()
            wordOrderLabel.text = "\(currentWordIndex + 1) / \(words.count)"

        }
    }
    
}
