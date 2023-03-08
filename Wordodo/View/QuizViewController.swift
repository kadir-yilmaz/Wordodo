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

class QuizViewController: UIViewController {
    
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

    var sorular = [Word]()
    var secenekler = [Word]()
    var yanlisSecenekler = [Word]()
    var soru = Word()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var timer = Timer()
    var counter = 60
    var score = 0
    
    private var interstitial: GADInterstitialAd?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
        
        // sayaç için
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(geriSay), userInfo: nil, repeats: true)
        
        // reklam için
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                interstitial?.fullScreenContentDelegate = self

                              }
            )

    }
    
    @objc func geriSay(){
        
        timeLabel.text = "\(counter)"
        counter -= 1
        
        if counter == -1 {
            timer.invalidate()
            score = 4 * dogruSayac -  1 * yanlisSayac
            
            if let currentUserUid = Auth.auth().currentUser?.uid {
                let db = Firestore.firestore()
                let userDocRef = db.collection("users").document(currentUserUid)
                
                userDocRef.updateData(["user_score": FieldValue.increment(Int64(score))]) { error in
                    if let error = error {
                        print("Error updating user score: \(error.localizedDescription)")
                    } else {
                        print("User score updated successfully")
                    }
                }
            } else {
                print("User is not logged in")
            }
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }
            performSegue(withIdentifier: "toResultVC", sender: nil)
        }
        
    }
    
    func loadWords() {
        WebService.shared.loadWords(from: QuizViewController.url1) { [weak self] words, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let words = words {
                self?.sorular = words
                DispatchQueue.main.async {
                    self?.soruYukle()
                }
            }
        }
    }

    func getWrongWords(forWordId wordId: Int) {
        WebService.shared.getWrongWords(forWordId: wordId, from: QuizViewController.url2) { [weak self] words, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let words = words {
                self?.yanlisSecenekler = words
                DispatchQueue.main.async { [weak self] in
                    self?.secenekler.removeAll()
                    self?.secenekler.append(self?.yanlisSecenekler[0] ?? Word())
                    self?.secenekler.append(self?.yanlisSecenekler[1] ?? Word())
                    self?.secenekler.append(self?.yanlisSecenekler[2] ?? Word())
                    self?.secenekler.append(self?.soru ?? Word())
                    self?.secenekler.shuffle()
                    self?.buttonA.setTitle(self?.secenekler[0].wordTr, for: .normal)
                    self?.buttonB.setTitle(self?.secenekler[1].wordTr, for: .normal)
                    self?.buttonC.setTitle(self?.secenekler[2].wordTr, for: .normal)
                    self?.buttonD.setTitle(self?.secenekler[3].wordTr, for: .normal)
                }
            }
        }
    }

    
    func soruYukle()  {
        trueLabel.text = "Doğru : \(dogruSayac)"
        falseLabel.text = "Yanlış : \(yanlisSayac)"
        
        soru = sorular[soruSayac]
        wordEnLabel.text = soru.wordEn
        
        if let wordId = self.soru.wordId, let id = Int(wordId) {
            self.getWrongWords(forWordId: id)
        } else {
            print("wordId değeri nil!")
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
        
        if soruSayac != sorular.count {
            soruYukle()
        }else{
            counter = 0
            performSegue(withIdentifier: "toResultVC", sender: nil)
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destination = segue.destination as! ResultViewController
            destination.trueCount = dogruSayac
            destination.falseCount = yanlisSayac
            destination.scoreCount = score

        }
    }
    

    
}

extension QuizViewController: GADFullScreenContentDelegate {
        
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
