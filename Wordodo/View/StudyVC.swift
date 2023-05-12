//
//  StudyViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit
import Alamofire
import GoogleMobileAds
import AVFoundation

class StudyVC: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var wordOrderLabel: UILabel!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    
    var viewModel = StudyViewModel()
    
    var audioPlayer: AVPlayer!

    var words: [Word] = []
    var currentWordIndex = 0
    var wordCard: WordCardView!
    
    static var url = ""
    static var audioUrl = URL(string: "")
    
    override func viewDidLoad()   {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let cardWidth: CGFloat = screenWidth * 0.7
        let cardHeight: CGFloat = screenHeight * 0.2
        let cardX = (screenWidth - cardWidth) / 2
        let cardY = (screenHeight - cardHeight) / 3.5
        
        wordCard = WordCardView(frame: CGRect(x: cardX, y: cardY, width: cardWidth, height: cardHeight))
        
        view.addSubview(wordCard)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        bannerView.rootViewController = self
            
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadWords()
        loadBannerAd()

      }
    
    
    
    @IBAction func sliderFunc(_ sender: UISlider) {
        
        currentWordIndex = Int(sender.value - 1)
        wordOrderLabel.text = "\(currentWordIndex + 1) / \(words.count)"
        updateWordCard()
        sender.maximumValue = Float(words.count)
        
    }
    
      override func viewWillTransition(to size: CGSize,
                              with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        coordinator.animate(alongsideTransition: { _ in
          self.loadBannerAd()
        })
      }
    
    
    @IBAction func playSoundButtonClicked(_ sender: Any) {
        viewModel.playSound()
    }
    
    func loadBannerAd() {
        
      let frame = { () -> CGRect in
          
        if #available(iOS 11.0, *) {
          return view.frame.inset(by: view.safeAreaInsets)
        } else {
          return view.frame
        }
      }()
      let viewWidth = frame.size.width
        
      bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)

      bannerView.load(GADRequest())
    }
    
    func loadWords()  {
        WebService.shared.fetchWords(url: StudyVC.url) { (words) in
            self.words = words
            self.updateWordCard()
            DispatchQueue.main.async {
                self.updateWordCard()
                self.wordOrderLabel.text = "\(self.currentWordIndex + 1) / \(self.words.count)"
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
        self.wordSentenceTextView.text = word.wordSentence
        
        // boşluk url'de %20 ile temsil edilir
        let encodedWordEn = word.wordEn!.lowercased().replacingOccurrences(of: " ", with: "%20")
        StudyVC.audioUrl = URL(string: "https://ssl.gstatic.com/dictionary/static/sounds/20200429/\(encodedWordEn)--_gb_1.mp3")        
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentWordIndex < words.count - 1 {
                    currentWordIndex += 1
            slider.maximumValue = Float(words.count)
            slider.value += 1
                    updateWordCard()
            wordOrderLabel.text = "\(currentWordIndex + 1) / \(words.count)"

                }
    }
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        if currentWordIndex > 0 {
                   currentWordIndex -= 1
            slider.maximumValue = Float(words.count)
            slider.value -= 1
                   updateWordCard()
            wordOrderLabel.text = "\(currentWordIndex + 1) / \(words.count)"
            
        }
    }
    
}

