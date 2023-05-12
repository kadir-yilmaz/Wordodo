//
//  QuizViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation
import GoogleMobileAds

class QuizViewModel  {
    
    var interstitial: GADInterstitialAd?
    
    var timer = Timer()

    func loadAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
        }
    }
    
    func runTimer(action: @escaping () -> ()) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            action()
        }
    }

}
