//
//  WordCardView.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import Foundation
import UIKit

class WordCardView: UIView {
    
    var wordLabel: UILabel!
    var meaningLabel: UILabel!
    var isFlipped: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        wordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2))
        wordLabel.textAlignment = .center
        
        addSubview(wordLabel)

        meaningLabel = UILabel(frame: CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2))
        meaningLabel.textAlignment = .center
        meaningLabel.isHidden = true
        addSubview(meaningLabel)
        
        // Font özellikleri oluşturuluyor
        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        // Özelliklerden NSAttributedString oluşturuluyor
        let attributedString = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.font: font])

        // Label text olarak NSAttributedString atanıyor
        wordLabel.attributedText = attributedString
        meaningLabel.attributedText = attributedString

        layer.cornerRadius = 10
        backgroundColor = UIColor.white
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(flip))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func flip() {
        UIView.transition(with: self, duration: 0.5, options: [.transitionFlipFromRight], animations: {
            if self.isFlipped {
                self.meaningLabel.isHidden = true
                self.wordLabel.isHidden = false
            } else {
                self.meaningLabel.isHidden = false
                self.wordLabel.isHidden = true
            }
            self.isFlipped.toggle()
        })
    }
    
}
