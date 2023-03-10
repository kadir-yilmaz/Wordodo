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

class StudyViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var wordOrderLabel: UILabel!
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    var viewModel = StudyViewModel()
    
    var audioPlayer: AVPlayer!

    var words: [Word] = []
    var currentWordIndex = 0
    var wordCard: WordCardView!
    
    static var url = ""
    static var audioUrl = URL(string: "")
    
    override func viewDidLoad()   {
        super.viewDidLoad()
        
        loadWords()
        
        wordCard = WordCardView(frame: CGRect(x: 50, y: 200, width: 300, height: 200))
        view.addSubview(wordCard)
        
        // Step 1 - Create a GADBannerView (in code or interface builder) and set the
            // ad unit ID on it.
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
            bannerView.rootViewController = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Note loadBannerAd is called in viewDidAppear as this is the first time that
        // the safe area is known. If safe area is not a concern (e.g., your app is
        // locked in portrait mode), the banner can be loaded in viewWillAppear.
        loadBannerAd()
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
        // Step 2 - Determine the view width to use for the ad width.
        let frame = { () -> CGRect in
          // Here safe area is taken into account, hence the view frame is used
          // after the view has been laid out.
          if #available(iOS 11.0, *) {
            return view.frame.inset(by: view.safeAreaInsets)
          } else {
            return view.frame
          }
        }()
        let viewWidth = frame.size.width

        // Step 3 - Get Adaptive GADAdSize and set the ad view.
        // Here the current interface orientation is used. If the ad is being preloaded
        // for a future orientation change or different orientation, the function for the
        // relevant orientation should be used.
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)

        // Step 4 - Create an ad request and load the adaptive banner ad.
        bannerView.load(GADRequest())
      }
    
    
    
    func loadWords()  {
        WebService.fetchWords(url: StudyViewController.url) { (words) in
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
        let encodedWordEn = word.wordEn!.replacingOccurrences(of: " ", with: "%20")
        StudyViewController.audioUrl = URL(string: "https://ssl.gstatic.com/dictionary/static/sounds/20200429/\(encodedWordEn)--_gb_1.mp3")        
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

