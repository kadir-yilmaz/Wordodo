//
//  StudyViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation
import AVFoundation

class StudyViewModel {
    
    var audioPlayer = AVPlayer()
    
    func playSound(){

        let playerItem = AVPlayerItem(url: StudyVC.audioUrl!)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer.play()
    }
}
