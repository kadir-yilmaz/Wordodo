//
//  UserWordTableViewCell.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit

class UserWordTableViewCell: UITableViewCell {
    
    var wordCard: WordCardView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let cardWidth: CGFloat = screenWidth * 0.7
        let cardHeight: CGFloat = screenHeight * 0.2
        
        let cardX = (screenWidth - cardWidth) / 2
        let cardY = (screenHeight - cardHeight) / 30
        
        wordCard = WordCardView(frame: CGRect(x: cardX, y: cardY, width: cardWidth, height: cardHeight))
        contentView.addSubview(wordCard)
    }

    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
