//
//  QuizViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import UIKit
import Alamofire

class QuizViewController: UIViewController {
    
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var wordEnLabel: UILabel!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    var url123 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get10WordsFromAnimals.php"
    
    var sorular = [Word]()
    var yanlisSecenekler = [Word]()
    var soru = Word()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var secenekler = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
        

    }
    
    func loadWords() {
        AF.request(url123, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(JSONResponse.self, from: data)
                    if let gelenKelimeListesi = cevap.words {
                        self.sorular = gelenKelimeListesi

                    }
                    DispatchQueue.main.async {
                        self.soruYukle()
                        
                    }
                } catch {
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    func soruYukle()  {
        trueLabel.text = "Doğru : \(dogruSayac)"
        falseLabel.text = "Yanlış : \(yanlisSayac)"
        
        soru = sorular[soruSayac]
        wordEnLabel.text = soru.wordEn
        wordSentenceTextView.text = soru.wordSentence
        
        if let wordId = self.soru.wordId, let id = Int(wordId) {
            self.getWrongWords(forWordId: id)
        } else {
            print("wordId değeri nil!")
        }


        
       
    }
    
    
    func getWrongWords(forWordId wordId: Int) {
        let urlString = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWord.php?word_id=\(wordId)"
        AF.request(urlString, method: .get).response { [self] response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(JSONResponse.self, from: data)
                    if let gelenKelimeListesi = cevap.words {
                        
                        self.yanlisSecenekler = gelenKelimeListesi
                        
                        
                        DispatchQueue.main.async { [self] in
                            
                            self.secenekler.removeAll()
                            
                            secenekler.append(yanlisSecenekler[0])
                            secenekler.append(yanlisSecenekler[1])
                            secenekler.append(yanlisSecenekler[2])
                            secenekler.append(soru)
                            
                            secenekler.shuffle()
                            
                            self.buttonA.setTitle(secenekler[0].wordTr, for: .normal)
                            self.buttonB.setTitle(secenekler[1].wordTr, for: .normal)
                            self.buttonC.setTitle(secenekler[2].wordTr, for: .normal)
                            self.buttonD.setTitle(secenekler[3].wordTr, for: .normal)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    

    
    @IBAction func buttonAClicked(_ sender: Any) {
        dogruKontrol(button: buttonA)
        soruSayacKontrol()
    }
    
    
    @IBAction func buttonBClicked(_ sender: Any) {
        dogruKontrol(button: buttonB)
        soruSayacKontrol()
    }
    
    
    @IBAction func buttonCClicked(_ sender: Any) {
        dogruKontrol(button: buttonC)
        soruSayacKontrol()
    }
    
    
    @IBAction func buttonDClicked(_ sender: Any) {
        dogruKontrol(button: buttonD)
        soruSayacKontrol()
    }
    
    func dogruKontrol(button:UIButton){
        
        let secilenCevap = button.titleLabel?.text
        let dogruCevap = soru.wordTr
        
        if dogruCevap == secilenCevap {
            dogruSayac += 1
        }else{
            yanlisSayac += 1
        }
        
        trueLabel.text = "Doğru : \(dogruSayac)"
        falseLabel.text = "Yanlış : \(yanlisSayac)"
        
    }
    
    func soruSayacKontrol(){
        soruSayac += 1
        
        if soruSayac != 10 {
            soruYukle()
        }else{
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
    }
    
    
}
